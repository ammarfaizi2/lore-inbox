Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132626AbRDQHhN>; Tue, 17 Apr 2001 03:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132629AbRDQHhD>; Tue, 17 Apr 2001 03:37:03 -0400
Received: from smtphost5.home.se ([195.66.35.201]:4966 "EHLO smtp2.home.se")
	by vger.kernel.org with ESMTP id <S132626AbRDQHgv>;
	Tue, 17 Apr 2001 03:36:51 -0400
Message-Id: <5.0.2.1.0.20010417082956.02ee5008@mail11.mail.home.se>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 17 Apr 2001 09:28:14 +0200
To: Matti Aarnio <matti.aarnio@zmailer.org>, Drew Bertola <drew@drewb.com>
From: Gunnar Ahlberg <gunnar.ahlberg@home.se>
Subject: Re: "Why I get no more linux-kernel traffic ?"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010322022834.J23336@mea-ext.zmailer.org>
In-Reply-To: <15033.7145.547612.90560@champ.serialhacker.net>
 <15033.7145.547612.90560@champ.serialhacker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a another FAQ entry based on my experience

I've found that home.com and home.se are messing with MAPI extensions.
At home, you are able to setup your own rules, just like any reasonable 
MAPI server,
but I guess they are doing it wrong, or, I'm getting it wrong.
This is what I did,
I set up my email rule to move all messages from @vger to a separate folder 
on the mail server.
On home.se this is done through a web interface were you can setup basic 
email features like rules.
The mails are getting nicely to the new folder, but I can't download it 
from the email client,
Eudora. Just removing the rule helped, but, now I can't read my email over 
the web interface...
It's a tough mans world.
I guess that either Eudora is not communicating with the mail server correctly
or, the mail server are storing the mails in separate storage instead of 
sorting them for the display
view.

/G


>   The POSSIBLE reasons are FAQ items at the LKML FAQ:
>         http://www.tux.org/lkml/
>
>   Lately we have had bounces from lots of places, INCLUDING  @home.com !
>
>   However in your case I see no such events.
>   Everything seem to have worked just fine, until at circa 2:15 AM (EST)
>   on 16th of march was the last letter to you.
>
>   By the way, VGER's logs are not infinite,  only current plus 7 previous
>   days.  Good that you didn't wait for a week before wondering...


