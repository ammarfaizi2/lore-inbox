Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281027AbRKCTp6>; Sat, 3 Nov 2001 14:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281028AbRKCTps>; Sat, 3 Nov 2001 14:45:48 -0500
Received: from ns.suse.de ([213.95.15.193]:51207 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281027AbRKCTpa>;
	Sat, 3 Nov 2001 14:45:30 -0500
To: Dan Hollis <goemon@anime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECS k7s5a audio sound SiS 735 - 7012
In-Reply-To: <86ady56u3h.fsf@cam.ac.uk.suse.lists.linux.kernel> <Pine.LNX.4.30.0111021316150.4828-100000@anime.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Nov 2001 20:45:20 +0100
In-Reply-To: Dan Hollis's message of "2 Nov 2001 22:23:47 +0100"
Message-ID: <p73zo63prjj.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis <goemon@anime.net> writes:

> On 2 Nov 2001, John Fremlin wrote:
> > Who to talk to at SiS? They have a dubious web interface for sales and
> > marketing requests that I used, but I'd prefer to email someone who
> > knows what a datasheet actually is ;-)
> > Alsa doesn't advertise any contact with SiS at all :-(
> 
> I've already talked with SiS. They are insisting that they will write the
> drivers themselves, they dont want to release datasheets to anyone. The
> reply I got (Thu, 25 Oct 2001) they said they are working on OSS drivers
> in-house, and ALSA drivers are next.

ALSA drivers seem to work. A standard SuSE 7.2 install with yast2 alsa installer
had no problems with producing sound on a k7s5a.

The sound quality is somewhat poor however; but even with another sound card
this board is cheaper than the alternativesa and works very fast. 

-Andi (happy user of a k7s5a with a sblive) 
