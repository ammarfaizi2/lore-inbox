Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129902AbRAKIkx>; Thu, 11 Jan 2001 03:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAKIkn>; Thu, 11 Jan 2001 03:40:43 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:49958 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S129994AbRAKIkb>; Thu, 11 Jan 2001 03:40:31 -0500
From: Paul Bristow <paul@paulbristow.net>
Reply-To: paul@paulbristow.net
Date: Thu, 11 Jan 2001 09:44:11 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: dmeyer@dmeyer.net
In-Reply-To: <20010111030654.A21788@jhereg.dmeyer.net>
In-Reply-To: <20010111030654.A21788@jhereg.dmeyer.net>
Subject: Re: has anyone patched NVIDIA_kernel to work with 2.4.0?
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01011109441100.01057@zoltar.quantum.net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 January 2001 09:06, dmeyer@dmeyer.net wrote:
> Between 2.4.0-test10 and 2.4.0 enough stuff changed that I can't get
> the OpenGL NVIDIA_kernel module compiled and linked properly.  Has
> anyone else taken a shot at this?

This was on linuxgames.com: does this not work?  I haven't had time to try 
yet...

Unofficial NVIDIA Driver 2.4.0 Patch - Friday Jan 05 08:58:54 2001 - Updated 
by Crusader

phantomlord pointed out in our comments that the Christian "phoenix" Zander 
has produced a patch for NVIDIA's Linux kernel driver for use in conjunction 
with the recently released 2.4.0 kernel (phoenix wrote this code for the 
2.4.0 prerelease, but the patch should work with the final kernel tree 
without issues). Please note that this is an unofficial (and unsupported) 
solution, and that NVIDIA will likely release a new official driver version 
for use with the 2.4.x series shortly.

NVdriver Kernel Module Patch for Linux 2.4.0:
http://www.linuxgames.com/misc/patch-2.4.0-PR

-- 
Paul Bristow
http://paulbristow.net
ICQ#11965223
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
