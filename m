Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263025AbVCDTP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbVCDTP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVCDTMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:12:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:3043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263003AbVCDTLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:11:20 -0500
Date: Fri, 4 Mar 2005 11:12:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       jgarzik@pobox.com, davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <20050304183804.GB29857@kroah.com>
Message-ID: <Pine.LNX.4.58.0503041107320.11349@ppc970.osdl.org>
References: <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
 <20050303151752.00527ae7.akpm@osdl.org> <1109894511.21781.73.camel@localhost.localdomain>
 <20050303182820.46bd07a5.akpm@osdl.org> <1109933804.26799.11.camel@localhost.localdomain>
 <20050304032820.7e3cb06c.akpm@osdl.org> <1109940685.26799.18.camel@localhost.localdomain>
 <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org>
 <Pine.LNX.4.58.0503041020130.25732@ppc970.osdl.org> <20050304183804.GB29857@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Mar 2005, Greg KH wrote:
> 
> Ah crap, I just called the first release of such a tree, 2.6.11.1.

I don't think any of us really _know_ where we are going, and we're all 
just discussing our personal ideas of what should work.

As such, I think experimentation comes into it. Dammit, I want everybody
to know that I'm perfectly happy to change my mind and admit when I'm
wrong. I may not like it any more than the average person, but if the
2.6.x.y approach ends up working fine, why not? 

Iow, let's be open to some experimentation, and see what actually works.

> Are you sure we would ever do that?  We never have before...

Well, I think we've only ever done a single 2.6.x.y release before, and I 
think it's good that you try to make more of them. I'm not at all unhappy 
with your 2.6.11.1 - I just think that there might be more automation 
involved in the long run.

But automation takes time to build up and learn, and in the meantime doing 
it by hand and learning early is definitely the right thing to do. Maybe 
you doing it by hand just makes it clear that I was wrong about the need 
for some strict rules that are automatically enforced in the first place.

> And if you disagree, what _should_ we call it?  "-sucker" isn't good, as
> it only describes the people creating the tree, not any of the users :)

Let's try with the 2.6.x.y numbering scheme, it's simple, and maybe it 
ends up being sufficient. I just wanted to bring up the point that I don't 
think the sucker tree _has_ to be seen as a 2.6.x.y tree at all.

		Linus
