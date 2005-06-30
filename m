Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262979AbVF3O0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbVF3O0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 10:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbVF3O0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 10:26:43 -0400
Received: from mout.perfora.net ([217.160.230.41]:42455 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S262974AbVF3OYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 10:24:38 -0400
Subject: Re: reiser4 vs politics: linux misses out again
From: Christopher Warner <chris@servertogo.com>
To: shevek@bur.st
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1120134372.42c3e4e49e610@webmail.bur.st>
References: <1120134372.42c3e4e49e610@webmail.bur.st>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 05:44:00 -0400
Message-Id: <1120124641.29714.10.camel@sabrina>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:d2cbd72fb1ab4860f78cabc62f71ec31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sweeping change is nice, incremental change is much more sweeter. The
problem is that the "filesystem" in and of itself is where data is kept.
In most cases people who run commercial businesses aren't going to
change their filesystem type unless their is a clear advantage.

Therefore, you're argument negates real world. Your argument should be
more about structure and a seamless migration path.

The argument isn't about technical merit.

-- 
.-Christopher Warner---------------------------------------------.
| my email is recycled to be sure; bcc my personal email address |
`----------------------------------------------------------------'

On Thu, 2005-06-30 at 22:26 +1000, shevek@bur.st wrote:
> As far as I'm concerned, commercial trolls have successfully taken away
> linux's only ever chance to sweep the field.
> 
> It is now gone. OSX rocks harder than linux, the spotlight function is superb.
> 
> That plus this squabbling is buying m$ enough time to make their version.
> 
> I label according to the observed effect. I haven't read the code.
> 
> Linux coulda had the OSX-type spotlight thing working, plus twice as fast
> filesystem 6 months or a year before Apple ... and a couple of years before m$.
> 
> Someone shoulda simply forked it then. When Hans first said 'replace VFS with
> reiser4'. I doubt he could have done it by himself ... they (trolls) would
> simply isolate his work and write his efforts off as the typical actions of a
> lone looney ... as they already characterise him.
> 
> The achievement reiser4 represents cannot be overstated. Genuine linux
> developers would have bent over backwards to get this as the primary filesystem
> for linux. Noone has ever doubled filesystem performance before, as far as I
> know, except the BeOS development team who have been divided as spoils of war
> between the two major competitors Apple and M$.
> 
> And he did so in a way that (a) provides for simple expansion in arbitrary
> directions without hackish horror such as AVFS presents; and (b) enables
> provision of compatibility with any arbitrary filesystem featureset.
> 
> What is all the complaining about?
> 
> And who are these guys?
> 
> Reiser has chased around trying to respond to all your criticisms for how long
> now? A year? Many of the critics I recall hadn't even read the material on his
> web site. Are these the same people now further delaying linux's adoption of
> 21st century filesystem semantics?
> 
> So many of the arguments I read are circular.
> 
> eg
> 
> * reiser4 can't be included until it has had widespread testing.
> 
> * reiser4 shouldn't contain two levels of plugins, since plugins properly belong
> in the awful hackish AVFS layer, above the VFS layer.
> 
> In fact the main impediment to reiser4 having been widely tested, in my
> ill-educated opinion, is simply that the directories look like files. This
> means a lot of application code needs minor tweaks, or at least thorough
> testing. Yet, it should be trivial to fix reiser4 so that directories don't
> look like files, no? using plugins?
> 
> Some arguments against reiser4 show that the arguer in question is even less
> well educated than even myself. ie, the person has not even tried reiser4.
> 
> Anyone who has, finds themselves so blown away by the apparent doubling of speed
> of any disk-bound task, that they start to question how much effort must have
> gone into making previous filesystems so slow. Who ever thought putting a
> transaction log at the end of the disk furthest away from where the data needs
> to be written would be a good thing? Why should it not go just near to where
> the head happens to be already? Thankyou Hans for showing us how.
> 
> To argue that benchmarks do not truly reflect real world use, you must never
> have even taken the time to real world use this thing. While Herr Reiser has
> put years of his life, and now apparently also much of his money, into creating
> it for you.
> 
> Try and get a wider scope on life, people. What is better for the future? Slow,
> dawdling development on slow dawdling filesystems and their supporting
> architecture, when we have been shown a fully functioning, effective and I am
> led to believe, simple replacement?
> 
> Well, like I said at the start, it's too late, if you do not like that path. We
> are now trapped there. The masses of users who would have been attracted by
> linux beating Apple and M$ to the punch, are now fading into some potential
> parallel universe. It's not this one. Hang your heads in shame, and cry. We
> lost. We are back to the same commercial monopoly-dominated market that we ever
> had. The loser is all of us, the common good, which has been sacrificed for the
> good of the few, by the invisible hand of the market, and the collective
> unconsciousness.
> 
> Simeon
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


