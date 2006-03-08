Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWCHMA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWCHMA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWCHMA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:00:27 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:57287 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932500AbWCHMA0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:00:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KQDB0oJ2ea72YWw714xod0xGEzCSjiSf3utw1io117lN1wy6mErsS8RgHvvz/fYWfToOQRo5x5bgVSxPATs1RYZef5UBgrHNguCPDuUlgh7c4nnm7qTohjLNhwyEXkftDegKP1DGPY3LKBEgqjj6wJWNGNP3rJNV9/ufTFcmJ2I=
Message-ID: <ec92bc30603080400t5a4baf75v86cf6e11a4d464ed@mail.gmail.com>
Date: Wed, 8 Mar 2006 17:30:25 +0530
From: "Anshuman Gholap" <anshu.pg@gmail.com>
To: "Matthias Schniedermeyer" <ms@citd.de>
Subject: Re: [future of drivers?] a proposal for binary drivers.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <440EC2BA.7010108@citd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
	 <20060308102731.GO27946@ftp.linux.org.uk>
	 <ec92bc30603080252v7e795b4dm5116d4fe78f92cc7@mail.gmail.com>
	 <440EC2BA.7010108@citd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks mathhais, this made huge sense to me.

I will soon going to get a laptop ( centrino duo models are looking
great, but kindof out_of_my budget). I will see the vendors who  dont
have native linux drivers are not in that model, as a non-developer,
this is the only thing in_my_hand.

i have no idea why did i make the horrible decision to get dlink
router and pcmcia card, where as the linksys set has a working (some
ppl complain) native driver support for its cards. wish i can turn the
clock back.

again, thank you mattias for putting it into nice prespective :)

Regards,
Anshu.
On 3/8/06, Matthias Schniedermeyer <ms@citd.de> wrote:
> Anshuman Gholap wrote:
> > well ya, I knew i was running the risk to be labelled like that, cause
> > i thought to talk of this issue, more shake is needed that just stir.
> >
> > please dont get me wrong (even though i think most of you already
> > have), i own my graditude for the livelihood i am having to
> > linux,linus and co.
>
> To get to the point of the others binary-only-discussions.
>
> You only see that you can't use a device today.
> I know that is annoying, but you have to see the "big picture":
>
> Less hostility regarding binary-only drivers would lead to a "flood" of
> binary-only-drivers which are undebuggable and unmaintanable by the kernel
> developers. IOW you would be at the mercy of the vendor of the device to
> make a compatible driver in the future.
>
> But there is a planet-size catch:
> Vendors think in money. So if you have a device that is end of line most
> vendors couldn't care less if you can't use it anymore with current systems.
> Given that the vendor is still in business after all!
>
> So instead of having a paper-weight today you will have it a few years later.
> I don't see the big difference.
>
> IOW. A "new" device may be working today, but will be a paper-weight
> later.
> Whereas an "old" device will be a paper-weight today, if the vendor only
> provided binary-only drivers "back then" when it was "new".
>
> In contrast most times you have an OSS-driver it will work "indefinetly",
> as it can be maintained over the years.
>
> It's all a shifting of who is hurt and when. In the long run the current
> model should be working better and better. Whereas binary-only drivers
> would destroy/undermine the achievements we have now.
>
>
>
>
> --
> Real Programmers consider "what you see is what you get" to be just as
> bad a concept in Text Editors as it is in women. No, the Real Programmer
> wants a "you asked for it, you got it" text editor -- complicated,
> cryptic, powerful, unforgiving, dangerous.
>
>
