Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUKTRd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUKTRd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 12:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUKTRd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 12:33:28 -0500
Received: from verein.lst.de ([213.95.11.210]:30114 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263134AbUKTRd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 12:33:26 -0500
Date: Sat, 20 Nov 2004 18:33:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: mantel@suse.de, jason.davis@unisys.com
Cc: linux-kernel@vger.kernel.org
Subject: please revert patches.arch/es7000-exports in SLES9SP1
Message-ID: <20041120173321.GA25602@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hubert,

these exports that Unisys sent you have been rejected for legal reasons
(as unisys wants to sneak in hooks for their binary only modules),
please remove them from your tree aswell, thanks.
