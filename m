Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbUL0OCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbUL0OCq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 09:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbUL0OCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 09:02:46 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:4997 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261367AbUL0OCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 09:02:45 -0500
Date: Mon, 27 Dec 2004 14:03:09 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: pcf8591 boot time parameters
Message-ID: <20041227140309.GA3361@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to configure pcf8591 driver using boot time commandline
parameters? 

If yes, where are they described? I didn't find it. (<Help> doesn't say
anything).  also /linux-2.6.10/Documentation/i2c$ fgrep PCF * didn't reveal
anything related.

I only found documentation for module parameters by means of modinfo pcf8591

Cl<

