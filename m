Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292476AbSBUP6O>; Thu, 21 Feb 2002 10:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292480AbSBUP6G>; Thu, 21 Feb 2002 10:58:06 -0500
Received: from boink.boinklabs.com ([162.33.131.250]:38160 "EHLO
	boink.boinklabs.com") by vger.kernel.org with ESMTP
	id <S292476AbSBUP55>; Thu, 21 Feb 2002 10:57:57 -0500
Date: Thu, 21 Feb 2002 10:57:56 -0500
From: Charlie Wilkinson <cwilkins@boinklabs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Hard lock-ups on RH7.2 install - Via Chipset?
Message-ID: <20020221105756.A9728@boink.boinklabs.com>
In-Reply-To: <20020212105658.D11655@boink.boinklabs.com> <E16agiR-0002Sv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E16agiR-0002Sv-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 12, 2002 at 05:27:39PM +0000
X-Home-Sweet-Home: RedHat 6.0 / Linux 2.2.12 on an AMD K6-225
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 05:27:39PM +0000, Alan Cox waxed eloquent:
> 
> > What I found was that writing out to any two drives was fine.  Writing to
> > all four will consistently lock up the machine after about 5-10 seconds.
> > So it seems load related.  (No, I didn't try three drives.)
[...]
> Its just another identical report of VIA + high PCI load hanging. It might
> be the promise drivers it might be the chipset. However people have run the
> same set up on intel boards without seeing this kind of problem so its
> not clear.
> 
> 2.4.18pre9-ac has the newer ide layer, but Im dubious that will help

I can confirm that it still locks up.  :/  What can I do to help?
Anyone I should beat on, or send beer and pizza to?

-cw-

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            Charlie Wilkinson - cwilkins@boinklabs.com - N3HAZ
Parental Unit, UNIX Admin, Homebrewer, Cat Lover, Spam Fighter, HAM, SWLer...
    Visit the Radio For Peace International Website: http://www.rfpi.org/
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            CLOBBER INTERNET SPAM:  See!! <http://spam.abuse.net/>        
                                   Join!! <http://www.cauce.org/>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
QOTD:
The 50-50-90 rule: Anytime you have a 50-50 chance of getting something
right, there's a 90% probability you'll get it wrong.
