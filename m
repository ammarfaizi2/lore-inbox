Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbVCMHT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbVCMHT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 02:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbVCMHTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 02:19:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:25571 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263344AbVCMHSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 02:18:21 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050313081523.00c57b08@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 13 Mar 2005 08:17:32 +0100
To: John Richard Moser <nigelenki@comcast.net>,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: binary drivers and development
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
In-Reply-To: <4233C912.80706@comcast.net>
References: <6f6293f105031207535938c687@mail.gmail.com>
 <423075B7.5080004@comcast.net>
 <423082BF.6060007@comcast.net>
 <16944.49977.715895.8761@wombat.chubb.wattle.id.au>
 <4230CB07.3020904@comcast.net>
 <6f6293f105031207535938c687@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0510-0, 03/08/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:01 AM 3/13/2005 -0500, John Richard Moser wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>You wanna give me a quick run-down on x86 of CPL and Ring levels?  It's
>been bugging me.  I know they're there and have a basic idea that they
>control what a context can do, don't know what CPL stands for, and
>there's a visible gap in my knowledge.  I like to understand everything,
>it makes things easier.

http://appzone.intel.com/literature/index.asp to locate the Intel processor 
of your choice, or 
http://developer.intel.com/design/pentium4/manuals/index_new.htm#sdm_vol1 
for P4.

         -Mike 

