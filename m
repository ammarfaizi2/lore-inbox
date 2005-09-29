Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVI2TfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVI2TfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVI2Te7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:34:59 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:41211 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S964806AbVI2Teu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:34:50 -0400
Subject: Re: [howto] Kernel hacker's guide to git, updated
From: Jon Loeliger <jdl@freescale.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
In-Reply-To: <200509292108.11092.oliver@neukum.org>
References: <433BC9E9.6050907@pobox.com>
	 <200509292108.11092.oliver@neukum.org>
Content-Type: text/plain
Message-Id: <1128022473.14595.6.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Date: Thu, 29 Sep 2005 14:34:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 14:08, Oliver Neukum wrote:

> Unfortunately, following the instructions to the letter produces this:
> oliver@oenone:~/linux-2.6> git checkout
> usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])

Yeah.  See if you still have a .git/HEADS that symlinks
to a valid place or not...?

jdl


