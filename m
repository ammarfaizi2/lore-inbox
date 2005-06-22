Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVFVOmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVFVOmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVFVOjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:39:37 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:5032 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261335AbVFVOha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:37:30 -0400
Date: Wed, 22 Jun 2005 16:37:29 +0200
From: Sander <sander@humilis.net>
To: Valdis.Kletnieks@vt.edu
Cc: Lee Revell <rlrevell@joe-job.com>, Adam Goode <adam@evdebs.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: IBM HDAPS Someone interested?
Message-ID: <20050622143729.GA17527@favonius>
Reply-To: sander@humilis.net
References: <20050620155720.GA22535@ucw.cz> <005401c575b3_5f5bba90_600cc60a@amer.sykes.com> <20050620163456.GA24111@ucw.cz> <20050620165703.GB477@openzaurus.ucw.cz> <20050620204533.GA9520@ucw.cz> <1119303016.5194.24.camel@lynx.auton.cs.cmu.edu> <1119368259.19357.18.camel@mindpipe> <200506211816.j5LIGj3E020507@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506211816.j5LIGj3E020507@turing-police.cc.vt.edu>
X-Uptime: 16:08:28 up 4 days, 40 min, 15 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote (ao):
> On Tue, 21 Jun 2005 11:37:38 EDT, Lee Revell said:
> > On Mon, 2005-06-20 at 17:30 -0400, Adam Goode wrote:
> > > Freefall detection: 300 ms
> > > Head park time: 300-500 ms
> 
> > Ugh, if userspace can't meet a 300ms RT constraint, that's a pretty
> > shitty OS you have there.
> 
> Actually, it's a lot tighter than that. You need to *issue* the "park
> head" command 300-500ms before it hits the ground, and you have 300ms
> of free fall.
> 
> So you may have needed to detect the free fall and issue the command
> 200ms before the free fall commences.
> 
> That's a *real* hard RT constraint to keep. ;)

FWIW. I have a X40 and am still running windows. The harddisk protection
software has an icon in the windows bar near the clock which shows if
the disk is 'not parked', 'parked due to movement of the notebook', or
'not parked, but a steady stream of possible harmless shocks is
noticed'.

The software reacts very quick and is very sensitive. The slightest
movement of the notebook makes the disk park its heads instantly (very,
very quick) for a moment with a fairly loud click. Even if you just
slide the notebook a centimeter over the table or tilt it a little. The
software also has a realtime '3D' image of the notebook which show the
tilting of the notebook. Pretty neat.

I once tripped over the network cable and had the notebook fly through
the air and eventually hit the floor. The harddisk was still fine (as
was the rest of the notebook which impressed me because the lid was in a
180 degree angle with the keyboard after it hit the floor).

Please let me know if I can be of any help running windows or linux.

        With kind regards, Sander
