Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318061AbSIOOpp>; Sun, 15 Sep 2002 10:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318062AbSIOOpp>; Sun, 15 Sep 2002 10:45:45 -0400
Received: from dsl-213-023-039-078.arcor-ip.net ([213.23.39.78]:19328 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318061AbSIOOpo>;
	Sun, 15 Sep 2002 10:45:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Sun, 15 Sep 2002 16:53:15 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <E17qRfU-0001qz-00@starship> <20020915020739.A22101@devserv.devel.redhat.com>
In-Reply-To: <20020915020739.A22101@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qalv-0000B6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 08:07, Pete Zaitcev wrote:
> > From: Daniel Phillips <phillips@arcor.de>
> > Date: Sun, 15 Sep 2002 07:10:00 +0200
> 
> >[...]
> > Let's try a different show of hands: How many users would be happier if
> > they knew that kernel developers are using modern techniques to improve
> > the quality of the kernel?
> 
> I do not see how using a debugger improves a quality of the kernel.

It improves my quality of life, that would be enough by itself.  And
since I am doing this purely for my own satisfaction at the moment, I
*will not* waste my time screwing around with 60's tools because
somebody who is paid whether or not they work productively thinks they
imbue the kernel with some kind of airy-fairy zen quality.

Look, we tried the zen state thing.  It didn't work.  Think about the
madness in the period between 2.3 and 2.4, with one oops after another
reported to the list, each taking days or weeks to track down.  Sure,
it allowed Linus and Al to show off their superior powers of cerebration,
solving the things given only a few lines of oops as a result, but it
sure fucked everything else up.  As I recall, it wasn't fun at all in
the end, not for Linus or Al either, and some folks got pretty close
to burned out.

The answer to the question "is this sillyness slowing down development
and reducing the quality of the kernel?" is "yes".  I don't have to
speculate about that any more, I've seen it enough with my own eyes.
Now ask yourself who the most productive hackers are today, and ask
yourself if they are using the good ol zen state blunt edged tools.

> Good thinking and coding does improve kernel quality. Debugger
> certainly does not help if someone cannot code.

Sorry, but you are full of shit.

-- 
Daniel
