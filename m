Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288788AbSAEL7G>; Sat, 5 Jan 2002 06:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288787AbSAEL6z>; Sat, 5 Jan 2002 06:58:55 -0500
Received: from tangens.hometree.net ([212.34.181.34]:32669 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S288781AbSAEL6j>; Sat, 5 Jan 2002 06:58:39 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Two hdds on one channel - why so slow?
Date: Sat, 5 Jan 2002 11:58:37 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <a16ppd$shs$1@forge.intermeta.de>
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A5A@ottonexc1.ottawa.loran.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1010231917 27731 212.34.181.4 (5 Jan 2002 11:58:37 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sat, 5 Jan 2002 11:58:37 +0000 (UTC)
X-Warning: This article could contain indecent words in German and/or English.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you don't want to read such words, please use a Killfile.
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)

Dana Lacoste <dana.lacoste@peregrine.com> writes:

>Also the bandwidth differences :

>Firewire (Generation 1, what you can get now) is 400Mbit/s
>FC Gen 1 is 100MByte/s
>Gen 2 is 200MByte/s
>(OK, I know those last two numbers are right, but I don't
>know what the NAMES of the standards are :)

>Firewire isn't even supposed to be in the same league! :)

That wasn't supposed of IDE in the war against SCSI either, but look
where we're now. :-)

The one argument that noone brought around here is (and it is the
killer argument for me in IDE vs. SCSI): "external disk trays". Try
that with IDE (current IDE please. No SerialATA. ;-) ) without lots of
"out of spec" cables dangling out of your "enterprise computing
solution".

If you need more than say, three or four disks, your solution is
SCSI. Or FibreChannel.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
