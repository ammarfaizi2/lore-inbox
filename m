Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287838AbSAFMUk>; Sun, 6 Jan 2002 07:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287840AbSAFMUe>; Sun, 6 Jan 2002 07:20:34 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:45224 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S287838AbSAFMUV>; Sun, 6 Jan 2002 07:20:21 -0500
Date: Sun, 6 Jan 2002 07:19:46 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Dave Jones <davej@suse.de>
cc: "H. Peter Anvin" <hpa@zytor.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.33.0201060218080.29977-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.43.0201060717560.20756-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Dave , All ,

On Sun, 6 Jan 2002, Dave Jones wrote:

> On Sat, 5 Jan 2002, H. Peter Anvin wrote:
>
> > ... and if you want to see something that's worse than either, check out
> > /proc/ide/hda/identify.
> AFAIAC, the /proc/ide/ stuff should never have happened.
> It's proven that every bit of it can be done in userspace.
	Then lets get rid of /proc/scsi , How about /proc/sys ...
	What is the differance here ?  Maybe I am missing something ?
		Hoping for enlightenment .  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

