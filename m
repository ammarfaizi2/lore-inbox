Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317605AbSFMNX4>; Thu, 13 Jun 2002 09:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSFMNXz>; Thu, 13 Jun 2002 09:23:55 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:7431 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317605AbSFMNXx>; Thu, 13 Jun 2002 09:23:53 -0400
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Alan <alan@clueserver.org>, linux-kernel@vger.kernel.org,
        "Witek Krecicki" <adasi@kernel.pl>
Subject: Re: Status of FAT CVF?
In-Reply-To: <1023856708.2934.9.camel@summanulla.clueserver.org>
	<20020612065417.GE30507@clusterfs.com>
	<87it4ocshn.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 13 Jun 2002 22:22:36 +0900
Message-ID: <87wut3ia8z.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline

X-From-Line: nobody Thu Jun 13 08:24:32 2002
Received: via dmail-2000(11) for +INBOX; Thu, 13 Jun 2002 03:40:21 +0900 (JST)
X-F: <adasi@kernel.pl> Thu Jun 13 03:38:32 2002
Received: from ep09.kernel.pl [212.87.11.162] by mail.parknet.co.jp with ESMTP
  (SMTPD32-4.10) id A625304B0138; Thu, 13 Jun 2002 03:38:29 +0900
Received: (qmail 27371 invoked from network); 12 Jun 2002 18:37:13 -0000
Received: from en57.kernel.pl (HELO witek) (212.160.87.116)
  by ep09.kernel.pl with SMTP; 12 Jun 2002 18:37:13 -0000
Message-ID: <034c01c21240$3d0e7600$0201a8c0@witek>
From: "Witek Krecicki" <adasi@kernel.pl>
To: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
In-Reply-To: <1023856708.2934.9.camel@summanulla.clueserver.org><20020612065417.GE30507@clusterfs.com> <87it4ocshn.fsf@devron.myhome.or.jp>
Subject: Re: Status of FAT CVF?
Date: Wed, 12 Jun 2002 20:37:37 +0200
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
X-RCPT-TO: <hirofumi@mail.parknet.co.jp>
X-UIDL: 303050499
Status: U
Lines: 36
Xref: devron.myhome.or.jp linux:372
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

----- Original Message -----
From: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
To: "Andreas Dilger" <adilger@clusterfs.com>
Cc: "Alan" <alan@clueserver.org>; <linux-kernel@vger.kernel.org>; "Witek
Krecicki" <adasi@kernel.pl>
Sent: Wednesday, June 12, 2002 7:32 PM
Subject: Re: Status of FAT CVF?


> Andreas Dilger <adilger@clusterfs.com> writes:
>
> > On Jun 11, 2002  21:38 -0700, Alan wrote:
> > > What is the status of fat_cvf in 2.4.x?  Is the code abandoned?
> > > Supported? Working? Not working? Pining for the fnords?
> > >
> > > I have an old drive I am trying to get data off of and mounting the
> > > compressed partition via loopback does something strange.  The mount
> > > point shows no files, but "df" shows the correct amount for data used.
> > > (The compressed DriveSpace 3.x partition does contain data.)
> > >
> > > Not urgent.  (I can get the data other ways.)  Just wanting to know
how
> > > bad it is before I start wading into the code.
> >
> > There was a patch posted last week to l-k which basically removed CVF
> > support from the kernel entirely, because it was totally non-functional.
>
> I got direct email about it. Then he said, he ports and uses dmsdos on
> 2.4. And I asked if he can port dmsdos to 2.5 or not. So, currently
> that patch is pending.
>
> Witek, can you post a patch of dmsdos for 2.4?
Now I'm much-too-busy for it, but try when have some time... hope it'll work
WK

--=-=-=


-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--=-=-=--
