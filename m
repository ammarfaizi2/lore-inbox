Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131491AbQKJTaA>; Fri, 10 Nov 2000 14:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131598AbQKJT3u>; Fri, 10 Nov 2000 14:29:50 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:8206 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131491AbQKJT3c>; Fri, 10 Nov 2000 14:29:32 -0500
Message-ID: <3A0C4BB2.8D2B724D@timpanogas.org>
Date: Fri, 10 Nov 2000 12:25:38 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <Pine.LNX.4.30.0011101409240.19584-100000@back40.badlands.lexington.ibm.com> <3A0C48CD.5E3F99DF@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Claus is sloging into the box and we will be trying to track this down. 
If it is a problem in the Linux TCPIP stack, we'll post a report later
this afternoon as to where it looks like the problem is.  

Jeff

"Jeff V. Merkey" wrote:
> 
> Since I posted this on LKML, Claus over at sendmail.org seems more
> motivated to track it down.  (since it might appear on the front page of
> Linux today).  I would love your assistance Richard.
> It could be a local problem since smrsh also seems to be f_cked up as
> well, but I am seeing the same thing with an out of the box RH6.2.
> 
> Jeff
> 
> Richard A Nelson wrote:
> >
> > On Fri, 10 Nov 2000, Jeff V. Merkey wrote:
> >
> > > 8.11.1 has problems talking to older sendmails and qmail.  I've seen
> > > even worse problems on 8.11.1, and backreved it immediately, and the
> > > encryption stuff has a lot of build problems on Linux.
> >
> > Sounds like local build problems, possibly all the problems !
> >
> > I can assist if you want to build 8.11.1 on Linux
> > --
> > Rick Nelson
> > Life'll kill ya                         -- Warren Zevon
> > Then you'll be dead                     -- Life'll kill ya
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
