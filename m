Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132483AbRDHEVj>; Sun, 8 Apr 2001 00:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbRDHEV3>; Sun, 8 Apr 2001 00:21:29 -0400
Received: from mrelay.cc.umr.edu ([131.151.1.89]:57350 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S132483AbRDHEVV>;
	Sun, 8 Apr 2001 00:21:21 -0400
Date: Sat, 7 Apr 2001 23:17:29 -0500
From: David Fries <dfries@mail.win.org>
To: linux-kernel@vger.kernel.org
Subject: Re: goodbye
Message-ID: <20010407231729.A24163@d-131-151-189-65.dynamic.umr.edu>
In-Reply-To: <Pine.LNX.4.21.0104031800030.14090-100000@imladris.rielhome.conectiva> <20010404012102Z131724-406+7418@vger.kernel.org> <20010408023228.L805@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010408023228.L805@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Sun, Apr 08, 2001 at 02:32:28AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2001 at 02:32:28AM +0300, Matti Aarnio wrote:
> On Tue, Apr 03, 2001 at 06:14:33PM -0700, Michael Peddemors wrote:
> 	Well, comparing how much spam goes thru linux-mm vs. linux-kernel,
> 	I would say our methods are fairly effective.
> 
> 	The incentive behind the DUL is to force users not to post
> 	straight out to the world, but to use their ISP's servers
> 	for outbound email --- normal M$ users do that, after all.
> 	Only spammers - and UNIX powerusers - want to post directly
> 	to the world from dialups.  And UNIX powerusers should know
> 	better, and be able to use ISP relay service anyway.

I guess you will have to explain to me why that is supposed to be a
good thing to force people to go though their ISP.  I've had personal
experience where I returned to my University which forces everyone to
go though their mail spool and it took me a week or two before I
realized that any e-mail I sent off campus wasn't getting there and I
was using their mail services.  Turns out the university changed the
host names for our ip's and my hostname wasn't changed to reflect that
(stupid name I might add and not for human readability, the previous
ones were understandable.)

To this day I don't know what happened to those e-mails, I do know I
didn't get them and the desired people didn't get them.

There is a lot of comfort looking at /var/log/mail.log and seeing mail
accepted by the computer servicing the other person's account.  Now
all I have is, accepted by university, hope it gets there...

-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@mail.win.org        |
		+---------------------------------+
