Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131408AbQKYRiG>; Sat, 25 Nov 2000 12:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131410AbQKYRh4>; Sat, 25 Nov 2000 12:37:56 -0500
Received: from oe45.law3.hotmail.com ([209.185.240.213]:57867 "EHLO
        hotmail.com") by vger.kernel.org with ESMTP id <S131408AbQKYRhn>;
        Sat, 25 Nov 2000 12:37:43 -0500
X-Originating-IP: [209.96.17.207]
From: "William Scott Lockwood III" <thatlinuxguy@hotmail.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20001125003600.A28207@vger.timpanogas.org>
Subject: Re: setting up pppd dial-in on linux
Date: Sat, 25 Nov 2000 11:04:48 -0600
MIME-Version: 1.0
Content-Type: text/plain;       charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE45l0cwjERdXRrodWU00001118@hotmail.com>
X-OriginalArrivalTime: 25 Nov 2000 17:07:37.0101 (UTC) FILETIME=[35D3FBD0:01C05702]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,
  I am also VERY interested in this, particularly on getting modems to work
with Linux at all.  I'm not reading the list right now, but I'd appreciate
any feedback you can throw my way on this.   Esp. if you DO get it setup and
working.  It sure would be nice to see Linux FINALLY support more modems out
there.  Hell, my Internal USR ISA modem is not even supported, but FreeBSD
had had support for it for a long time now.  :-(  Please let me know what
you find out, and I'm VERY interested in your RPM - hope there will be a
straight tarball for us Slackware Dinosaurs too.  :-)

Scott

----- Original Message -----
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, November 25, 2000 1:36 AM
Subject: setting up pppd dial-in on linux


>
>
> Anyone out there a whiz at setting up a pppd dialin server?  I am
> trying to put together an RPM for pppd dialin configurations
> that will support default Windows NT and Linux dial in clients
> without requiring the poor user to learn bash scripting, chat
> scripting, mgetty and inittab configuration, etc.  The steps
> in setting this up are about as easy as going on a U.N. relief
> mission to equatorial Africa, and most customers who are
> "mere mortals" would give up about an hour into it.
>
> I am seeing massive problems with pppd dial-in and IP/IPX
> routing with problems that range from constant Oops, to
> the bug infested pppd daemon failing valid MD5 chap
> authentication.  The HOW-TO's and man pages provide
> wonderful commentary on all the things about pppd
> that don't work, but it's not too helpful on getting
> it to work reliably.  An NT dial-in server takes about
> 5 minutes to configure on W2K.  Linux takes about 2 days, and
> won't stay up reliably.
>
> Who out there is an expert on Linux pppd that would like
> to help put together some easy configs for standard
> dial-in scenarios?
>
> Thanks
>
> Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
