Return-Path: <linux-kernel-owner+w=401wt.eu-S1753172AbWLVXVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbWLVXVX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbWLVXVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 18:21:23 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:32848 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbWLVXVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 18:21:22 -0500
Date: Sat, 23 Dec 2006 00:21:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Rename FIELD_SIZEOF to MEMBER_SIZE and use in source
 tree.
In-Reply-To: <Pine.LNX.4.64.0612221013290.5467@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0612230020210.16006@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612221013290.5467@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>  Rename the macro FIELD_SIZEOF() in include/linux/kernel.h to
>MEMBER_SIZE(), and make a number of replacements in the source tree
>where that macro simplified the code.

Looks sane. (Random thought: SIZEOF_MEMBER())


	-`J'
-- 
