Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264692AbRFSSuG>; Tue, 19 Jun 2001 14:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbRFSSt5>; Tue, 19 Jun 2001 14:49:57 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:31541
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264692AbRFSSts>; Tue, 19 Jun 2001 14:49:48 -0400
Date: Tue, 19 Jun 2001 11:49:40 -0700
From: Larry McVoy <lm@bitmover.com>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote?
Message-ID: <20010619114940.A3089@work.bitmover.com>
Mail-Followup-To: Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B2F769C.DCDB790E@kegel.com> <dank@kegel.com> <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca> <3B2F769C.DCDB790E@kegel.com> <20010619090956.R3089@work.bitmover.com> <838x7gT1w-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <838x7gT1w-B@khms.westfalen.de>; from kaih@khms.westfalen.de on Tue, Jun 19, 2001 at 08:01:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 08:01:00PM +0200, Kai Henningsen wrote:
> The funny thing here, Larry, is that to most people (who aren't OS gurus),  
> Linux' clone or Plan 9's rfork *are* threads.
> 
> I certainly agree that you don't necessarily need two different kernel- 
> level kinds of things, but really, most of the time when people talk about  
> threads

Great, then we are in violent agreement on the single abstraction. 
On the second part, I stand by my previous statements that threads or
processes should be used sparingly.

All I'm doing is trying to counter all the "threads are great" hype.
This is a pretty intelligent pile of people but there are also a fair
number of people who read this list looking for nuggets of information.
If they walk away going "(a) Linux has a cool threading model, and 
(b) I should only use threads if I absolutely have to do so and even
then if there are more than there are CPUs I'm probably making a 
mistake", if they get that message, that's a good thing, IMHO.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
