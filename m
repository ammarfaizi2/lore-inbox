Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTEEGPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 02:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTEEGPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 02:15:22 -0400
Received: from 12-251-63-144.client.attbi.com ([12.251.63.144]:17741 "EHLO
	vlad.geekizoid.com") by vger.kernel.org with ESMTP id S261962AbTEEGPV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 02:15:21 -0400
Reply-To: <vlad@geekizoid.com>
From: "Vlad@geekizoid.com" <vlad@geekizoid.com>
To: "'Lkml \(E-mail\)'" <linux-kernel@vger.kernel.org>
Subject: RE: Error compiling 2.5.69 - gcc version
Date: Mon, 5 May 2003 01:27:37 -0500
Message-ID: <000401c312cf$6df922c0$0200a8c0@wsl3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <000701c312c2$e14ab1b0$0200a8c0@wsl3>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using:

Reading specs from /usr/lib/gcc-lib/i386-slackware-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release)

If anyone cares.

--

 /"\                         / For information and quotes, email us at
 \ /  ASCII RIBBON CAMPAIGN / info@lrsehosting.com
  X   AGAINST HTML MAIL    / http://www.lrsehosting.com/
 / \  AND POSTINGS        / vlad@lrsehosting.com
-------------------------------------------------------------------------

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
> Vlad@geekizoid.com
> Sent: Sunday, May 04, 2003 11:58 PM
> To: Lkml (E-mail)
> Subject: Error compiling 2.5.69
> 
> 
> I get the following error trying to compile 2.5.69.  This is 
> the same config as 2.5.68, make with 'make oldconfig' and 
> 'make bzlilo && make modules modules_install'.
> 
> Config and config.old attached.
> 
> Error:
> arch/i386/oprofile/init.c: In function `oprofile_arch_init':
> arch/i386/oprofile/init.c:25: `ENODEV' undeclared (first use 
> in this function)
> arch/i386/oprofile/init.c:25: (Each undeclared identifier is 
> reported only once
> arch/i386/oprofile/init.c:25: for each function it appears in.)
> arch/i386/oprofile/init.c:27: warning: control reaches end of 
> non-void function
> make[1]: *** [arch/i386/oprofile/init.o] Error 1
> make: *** [arch/i386/oprofile] Error 2
> 
> 
> --
> 
>  /"\                         / For information and quotes, email us at
>  \ /  ASCII RIBBON CAMPAIGN / info@lrsehosting.com
>   X   AGAINST HTML MAIL    / http://www.lrsehosting.com/
>  / \  AND POSTINGS        / vlad@lrsehosting.com
> --------------------------------------------------------------
> -----------
> 


