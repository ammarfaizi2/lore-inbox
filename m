Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275979AbRJBJkI>; Tue, 2 Oct 2001 05:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275981AbRJBJj6>; Tue, 2 Oct 2001 05:39:58 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:5138 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S275979AbRJBJjj>;
	Tue, 2 Oct 2001 05:39:39 -0400
Date: Tue, 2 Oct 2001 11:40:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] New Anti-Terrorism Law makes "hacking" punishable by life in prison
Message-ID: <20011002114006.B7117@suse.cz>
In-Reply-To: <20010927142311.E35@toy.ucw.cz> <HBEHIIBBKKNOBLMPKCBBIENPDNAA.znmeb@aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBIENPDNAA.znmeb@aracnet.com>; from znmeb@aracnet.com on Sun, Sep 30, 2001 at 02:16:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2001 at 02:16:40PM -0700, M. Edward Borasky wrote:

> While I don't want to get involved in a comparison between the loss of some
> 7000 human lives in a terrorist attack on buildings with productivity lost
> due to Code Red and Nimda attacks on the world's businesses, I'd like to
> make two points:
> 
> 1. The losses to businesses from just these two virus attacks are
> *significant*, and people are angry about the fact. They're looking for
> someone to blame, someone to propose a solution and tools to prevent future
> attacks. I personally think stiff fines and long prison sentences for
> releasing attack software into the world's business network should have been
> instituted a long time ago. Life without parole seems to me quite reasonable
> under the circumstances.

I think the major mistake behind this law is that it doesn't take into
account that not the whole world is America. Still, virus creators from
other countries won't be scared by this law, and I don't believe it'll
stop American virus writer either - they won't believe they'll be ever
caught.

> 2. The Linux community should *not* believe that we are less vulnerable than
> Microsoft! We are less vulnerable *now* only because Linux is not as
> widespread as Windows. Were Linux, say, half of the market, the
> vulnerability would be equal. The difference is strictly the number of
> available hosts for these parasitic codes, not anything inherent in the
> details of Windows or Linux, or in the organizational mechanisms (corporate
> giant vs. "brutal meritocracy", closed source vs. open source, etc.).
> 

Linux *is* less vulnerable to worm attacks, because of diversity.

There is just a few different versions of IIS, for example, just a few
different binaries floating around. And thus it is easy to choose the
most common one and write a buffer overflow exploit for it.

On the other way, there are many many different versions of Apache and
Linux around, and even for same versions the code is compiled with
different options by every Linux maker, which gives you at least a
couple hundreds of different binaries. This won't stop a hacker from
getting into your computer, but it will slow down worm spreading a lot -
it either has to know every different binary out there and be able to
guess which one is running on the system it plans to infect before it
attacks (because otherwise the server can just crash without being
infected, which is counterproductive for the virus), or hope to be able
to attack the most common binary, which will then have a much smaller
impact on the whole 'net.

It's much like biology: When you have genetic diversity, your species
won't become extinct after just one heavy plague - some will survive. If
you're a monoculture, then you're dead.

> In fact, I suspect that the open source for Linux gives creators of vicious
> attack codes a *slight* advantage, since the vulnerabilities are there for
> anyone to read and exploit before they are found by an alert Linux
> community. And if Linux is to succeed in the enterprise, we in the community
> owe it to ourselves to *enhance* that alertness -- indeed, to be more
> vigilant on security issues -- even if it's at the expense of some of our
> more favorite activities, like performance tweaking.

Being alert is always good. :) It just becomes tiring after some time.

-- 
Vojtech Pavlik
SuSE Labs
