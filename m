Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUGODjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUGODjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 23:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUGODjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 23:39:17 -0400
Received: from penguin.linuxhardware.org ([63.173.68.170]:42113 "EHLO
	penguin.linuxhardware.org") by vger.kernel.org with ESMTP
	id S265812AbUGODjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 23:39:16 -0400
Date: Wed, 14 Jul 2004 23:44:16 -0400 (EDT)
From: augustus@linuxhardware.org
To: linux-kernel@vger.kernel.org
Subject: vim doesn't like the command line
Message-ID: <Pine.LNX.4.58.0407142340560.7017@penguin.linuxhardware.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is odd but it seems that vim 6.3 does not function properly with 
kernel 2.6.8-rc1.  It will not take command line arguement filenames.  No 
matter what you pass it, it always goes to the file browser.  This is not 
the case with 2.6.7 kernels.  Any ideas?  I have attached my kernel 
.config.

I am not subscribed to this list so please CC me on any responses.

Thanks,
Kris Kersey (Augustus)
LinuxHardware.org Site Manager
augustus@linuxhardware.org
Gentoo Linux AMD64 Developer
augustus@gentoo.org
