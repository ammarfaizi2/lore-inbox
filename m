Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVCHTeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVCHTeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVCHTcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:32:00 -0500
Received: from isilmar.linta.de ([213.239.214.66]:57816 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262097AbVCHT3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:29:01 -0500
Date: Tue, 8 Mar 2005 20:29:00 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: inconsistent kallsyms data [2.6.11-mm2]
Message-ID: <20050308192900.GA16882@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050308033846.0c4f8245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308033846.0c4f8245.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

compiling -mm2 on my x86 box results in:

SYSMAP  .tmp_System.map
Inconsistent kallsyms data
Try setting CONFIG_KALLSYMS_EXTRA_PASS
make: *** [vmlinux] Fehler 1

gcc-Version 3.4.3 20050110 (Gentoo Linux 3.4.3.20050110, ssp-3.4.3.20050110-0, pie-8.7.7)

	Dominik
