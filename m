Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263206AbREaUBA>; Thu, 31 May 2001 16:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbREaUAu>; Thu, 31 May 2001 16:00:50 -0400
Received: from mustart.heime.net ([194.234.65.222]:4100 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S263206AbREaUAk>; Thu, 31 May 2001 16:00:40 -0400
Date: Thu, 31 May 2001 22:00:39 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Vibol Hou <vhou@khmer.cc>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: union mounting file systems...
In-Reply-To: <NDBBKKONDOBLNCIOPCGHAEBEHGAA.vhou@khmer.cc>
Message-ID: <Pine.LNX.4.30.0105312157020.1301-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well...

I just wondered how to (if possible) union mount two or more filesystems
on a single mount point. The point that I want to bypass a bug/weakness in
RedHat's installer is not really the case. I've tried to search the kernel
mailing list archive, and find it's possible with mount -o union ...
Problem is that I still can't see nothing but the last file system mounted
on the mount point, so what is wrong?

It may be an issue for other forums than lkml, but I really don't think
RedHat is the place to go.

Best regards

roy

On Thu, 31 May 2001, Vibol Hou wrote:

> This sounds more like a RedHat issue than a LKML issue.  Take it up with
> RedHat.
>
> --
> Vibol Hou
> KhmerConnection, http://khmer.cc
> "Stay Connected."
>
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Roy Sigurd
> Karlsbakk
> Sent: Thursday, May 31, 2001 11:39 AM
> To: linux-kernel@vger.kernel.org
> Subject: union mounting file systems...
>
>
> Hi all
>
> I just read the "Wonderful world of linux (2.4)", where it's said that the
> Linux kernel 2.4 supports so-called union mounted file systems. I recently
> downloaded the RedHat 7.1 distribution and loop-back mounted the CD's to
> be able to install over ftp, but no... RedHat's install script reminds me
> of all the flexibility you can get from an installer delivered from
> Microsoft. After installing the stuff from CD #1, you're _not_ asked where
> CD #2 is supposed to be; you just get loads of error messages on the
> console. So - I can copy all the files from the two CD's - or - union
> mount them (the .iso's) on a common directory.
>
> Does anyone know where I can find a mount program that actually does this?
>
> Please cc: to me, as I'm not on the list
>
> regards
>
> roy
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

