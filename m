Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKYISm>; Sat, 25 Nov 2000 03:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQKYISd>; Sat, 25 Nov 2000 03:18:33 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:23936 "EHLO
        mirai.cx") by vger.kernel.org with ESMTP id <S129153AbQKYIST>;
        Sat, 25 Nov 2000 03:18:19 -0500
Message-ID: <3A1F6EB6.A5E47686@pobox.com>
Date: Fri, 24 Nov 2000 23:48:06 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting Group
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-ac2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: setting up pppd dial-in on linux
In-Reply-To: <20001125003600.A28207@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:

> Anyone out there a whiz at setting up a pppd dialin server?  I am
> trying to put together an RPM for pppd dialin configurations
> that will support default Windows NT and Linux dial in clients
> without requiring the poor user to learn bash scripting, chat
> scripting, mgetty and inittab configuration, etc.  The steps
> in setting this up are about as easy as going on a U.N. relief
> mission to equatorial Africa, and most customers who are
> "mere mortals" would give up about an hour into it.

Red Hat's ppp client setup is about a 90 second job

> I am seeing massive problems with pppd dial-in and IP/IPX
> routing with problems that range from constant Oops, to
> the bug infested pppd daemon failing valid MD5 chap
> authentication.  The HOW-TO's and man pages provide
> wonderful commentary on all the things about pppd
> that don't work, but it's not too helpful on getting
> it to work reliably.  An NT dial-in server takes about
> 5 minutes to configure on W2K.  Linux takes about 2 days, and
> won't stay up reliably.

hmm, an awful lot of ISPs use Linux dialup servers...

I set up a linux ppp server back in 1996 - things might have
changed, but it seemed fairly straightforward at the time -

can't imagine it's gotten worse since then...

> Who out there is an expert on Linux pppd that would like
> to help put together some easy configs for standard
> dial-in scenarios?

Crunch time for me right now, finals coming right up...

I'll bet there's quite a few ISP-savvy admins who could
lend a hand though -

jjs


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
