Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWAYRPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWAYRPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWAYRPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:15:18 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:5587 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750703AbWAYRPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:15:16 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 Jan 2006 18:14:15 +0100
To: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D7B1E7.nailDFJ9MUZ5G@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
In-Reply-To: <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:

> > [irrelevant discussion of other platforms]

Incorrect, sorry. Do you really make Linux incompatible to the rest of the 
world?


> > 17 Platforms _need_ the addressing scheme libscg offers
> > 5  Platforms _may_ use a different access method too.
>
> Wrong again:
> 17 platforms need libscg's addressing
> 4 platforms offer /dev/* access
> 1 platform (Linux) _requires_ /dev/* access

Your last line is wrong 

> You are perfectly free to adjust your compatibility layer accordingly.

The Linux Kernel fols unfortunately artificially hides information for the 
/dev/hd* interface making exactly this compatibility impossible.


> Personal attacks are offtopic, irrelevant, and rude.  Please refrain  
> from doing so.  If you don't plan to respond to somebody's email,  
> just don't, no reason to shout about it to a world who doesn't care.

If you are against personal attacks, why didn't you intercede for the
postings from Jens Axboe and Albert Cahalan?

I am against personal attacks and this is the first time where it tooks
more than a day before LKML people started with personal attacks against me.
So in principle this is some sort of progress compared to former times.
If you like to continue this discussion, I would like you to stay reasonable 
and help to keep the discussion stay based on technical based arguments.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
