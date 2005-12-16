Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVLPWMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVLPWMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVLPWMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:12:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:57274 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932457AbVLPWMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:12:12 -0500
Date: Fri, 16 Dec 2005 23:12:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
cc: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
Subject: Re: gtkpod and Filesystem
In-Reply-To: <dnul89$r4k$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0512162311180.24996@yvahk01.tjqt.qr>
References: <20051216145234.M78009@linuxwireless.org> <dnul89$r4k$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have Debian Sid with 2.6.15-rc5, I wonder if this could be either with a
>> bug in gtkpod or the kernel (FS Panic).
>
>Maybe an FS error on your iPod? Did you try to reformat or dosfsck it?

Even then, the filesystem code should handle corrupt filesystems more 
gracefully.


Jan Engelhardt
-- 
