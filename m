Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312477AbSCUUfW>; Thu, 21 Mar 2002 15:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312481AbSCUUfM>; Thu, 21 Mar 2002 15:35:12 -0500
Received: from ep09.kernel.pl ([212.87.11.162]:14254 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S312477AbSCUUe4>;
	Thu, 21 Mar 2002 15:34:56 -0500
Message-ID: <01a801c1d117$da899ff0$0201a8c0@WITEK>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.7] initrd issue
Date: Thu, 21 Mar 2002 21:33:58 +0100
Organization: PLD Team
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to use 2.5.7 with initrd. I checked almost all configuration
options, but it's still loading RAM-Disk in one line (ext2 filesystem
detected etc.) and 'freeing Xkb initrd memory' in the next one. On 2.2 there
was sth. like 'VFS: Mounting initrd..sth...' but there's nothing like that.
What's wrong? I've got initrd, romfs and (optionally) compressed romfs
support compiled-in
--
Witek 'adasi' Krêcicki|Emancipate yourselves from mental slavery
adasi[at]grubno.da.ru |None  but ourselves  can  free our  minds
GG:346981 +48502117580|  -  Bob  Marley,       Redemption   Song
...-=DOoGA=-....-=CRS00=-...-=CRSPoland=-....-=AI=-...-=PLD=-...




