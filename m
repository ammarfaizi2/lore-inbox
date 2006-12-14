Return-Path: <linux-kernel-owner+w=401wt.eu-S932871AbWLNRXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871AbWLNRXD (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932873AbWLNRXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:23:02 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41170 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932871AbWLNRXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:23:01 -0500
Date: Thu, 14 Dec 2006 09:22:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: "Michael K. Edwards" <medwards.linux@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <20061213235500.1764d85e@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612140905150.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com>
 <20061213210219.GA9410@suse.de> <45807182.1060408@mbligh.org>
 <20061213134721.d8ff8c11.akpm@osdl.org> <f2b55d220612131420l5f956e05qb10ef233670fb588@mail.gmail.com>
 <20061213235500.1764d85e@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Alan wrote:
> 
> He only owns a small amount of the code. Furthermore he imported third 
> party GPL code using the license as sole permission. So he may have dug 
> a personal hole but many of the rest of us have been repeatedly saying 
> whenever he said that - that we do not agree.

[ The "he" being me in the above ]

Btw, I'd like to make it clear in this discussion too (as I have in 
others), that I agree 100% with Alan here. 

The thing is, my opinion is really just _my_ opinion. People shouldn't see 
it as anything else. When I say "I don't think we should totally disallow 
binary modules", you should always keep in mind that:

 - the fact that I think that _some_ binary modules may be perfectly legal 
   does not mean that I think _all_ binary modules would be legal. I think 
   there are lots of ways to make such a binary module that is obviously 
   not ok.

 - I really _am_ just one of hundreds of copyright owners. The fact that 
   _I_ am not necessarily all that eager to take things to court should in 
   no way be seen as estoppel for _others_ who decide that they want to 
   flex their legal rights.

So when I "may have dug a personal hole", please realize that this is 
actually a personal - and conscious - choice. I've never wanted to do 
copyright assignments, for several reasons: I think they are nasty and 
wrong personally, and I'd hate all the paperwork, and I think it would 
actually detract from the development model.

But one of the reasons I've never wanted copyright assignments is that I'm 
personally actually _more_ comfortable with the system being co-owned. I 
_like_ having my hands bound, and being in that hole. Not because of any 
strange sexual hangups either, but simply because I think being personally 
limited is something that makes people trust me more in the end - or 
rather, it is something that means that people don't _have_ to trust me.

So people know that I can't unilaterally change the license. And they 
_know_ that they can actually take things to court on their own. AND THAT 
IS A GOOD THING. The last thing anybody _ever_ wants is to have me having 
absolute powers. Not you guys, and certainly not me.

So you guys should always be happy, realizing that Linus may have his 
quirks, but that my quirks can't ever really screw you guys up.

So I repeat: my opinions are _my_ opinions. Nobody else is legally bound 
by them. And I'm certainly willing to bend my behaviour in the presense of 
pressure (I think only mindless idiots can't change their mind - I 
personally change some of my opinions several times a day just to keep 
them fresh), but in somethign like this, where I _do_ have a fairly strong 
opinion, I really think that this kind of patch has to be merged in 
somebody elses tree than mine.

If, after a year, it turns out that my tree is the only one that doesn't 
have that clause, I think I'll either get the hint, or people will realize 
that I'm pointless and will just ignore me. It will have taken you long 
enough to realize that ;)

Because one of the great things about the GPL is that _nobody_ has the 
power to deny other peoples will. Not even me, not even for the kernel.

				Linus
