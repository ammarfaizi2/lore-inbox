Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVASCel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVASCel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 21:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVASCel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 21:34:41 -0500
Received: from main.gmane.org ([80.91.229.2]:24975 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261359AbVASCea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 21:34:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alban Browaeys <prahal@yahoo.com>
Subject: Re: thoughts on kernel security issues
Date: Wed, 19 Jan 2005 02:34:23 +0000 (UTC)
Message-ID: <loom.20050119T013904-64@post.gmane.org>
References: <20050114183415.GA17481@thunk.org><Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <Pine.LNX.4.58.0501141047470.2310@ppc970.osdl.org> <41ED8D5F.5030409@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.125.145.79 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Galeon/1.3.18.99 (Debian package 1.3.18+arch20050108-1))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen <at> tmr.com> writes:

> 
> With no disrespect, I don't believe you have ever been a full-time 
> employee system administrator for any commercial or government 
> organization, and I don't believe you have any experience trying to do 
> security when change must be reviewed by technically naive management to 
> justify cost, time, and policy implications. The people on the list who 
> disagree may view the security information issue in a very different 
> context.

Basically you are saying that if i disagree, my view is irrelevant. What do you
expect with this kind of start. 

> Linus Torvalds wrote:
> 
> > What vendor-sec does is to make it "socially acceptable" to be a parasite. 
> > 
> > I personally think that such behaviour simply should not be encouraged. If
> > you have a security "researcher" that has some reason to delay his
> > disclosure, you should see for for what he is: looking for cheap PR. You
> > shouldn't make excuses for it. Any research organization that sees PR as a
> > primary objective is just misguided.
> 
> There are damn fine reasons for not having immediate public disclosure, 
> it allows vandors and administrators to close the hole before the script 
> kiddies get a hold of it. And they are the real problem, because there 
> are so MANY of them, and they tend to do slash and burn stuff, wipe out 
> your files, steal your identity, and other things you have to notice. 
> They aren't smart enough to find holes themselves in most cases, they 
> are too lazy in many cases to read the high-level hacker boards, and a 
> few weeks of delay in many cases lets the careful avoid damage.
> 
> Security through obscurity doesn't work, but a small delay for a fix to 
> be developed can prevent a lot of problems. And of course the 
> information should be released, it encourages the creation and 
> installation of fixes.
>
> Oh, and many of the problem reports result in "cheap PR" consisting of a 
> single line mention in a CERT report or similar. Most people are not 
> doing it for the glory.

Nobody told against a small delay , in most of the case that is already what is
happening today. 
There is a little problem in this rhetoric. You want fix fast and disclosure
latter. As soon as the fix (we are talking about source available) is out, the
hole is too. Wondering if chiken or egg is great flame subject.

> 
> > What's the alternative? I'd like to foster a culture of
> > 
> >  (a) accepting that bugs happen, and that they aren't news, but making 
> >      sure that the very openness of the process means that people know
> >      what's going on exactly because it is _open_, not because some news 
> >      organization had to make a big stink about it just to make a vendor
> >      take notice.
> 
> Linux vendors aside, many vendors react in direct proportion to the bad 
> publicity engendered. I'd like the world to work that way, but in many 
> places it doesn't.
> > 
> >      Right now, people seem to think that big news media warnings on 
> >      cnet.com about SP2 fixing 15 vulnerabilities or similar is the proper
> >      way to get people to upgrade. That just -cannot- be right.
> 
> Unfortunately reality doesn't agree with you. Many organizations have no 
> other effective way to convince management of the need for a fix except 
> newspaper articles and magazine articles. A sometimes that has to get to 
> the horror story stage before action is possible.


All those to lines to say one thing . Managing security requires social skills.

 
> > And let's not kid ourselves: the security firms may have resources that 
> > they put into it, but the worst-case schenario is actual criminal intent. 
> > People who really have resources to study security problems, and who have 
> > _no_ advantage of using vendor-sec at all. And in that case, vendor-sec is 
> > _REALLY_ a huge mistake. 
> 
> I think you are still missing the point, I don't care if a security firm 
> reads mailing lists or tea leaves, does research or just knows where to 
> find it, they are paid to do it and if they do it well and report the 
> problems which apply to me and the source of the fixes they keep me from 
> missing something and at the same time save me time. Even reading only 
> good mailing lists and newsgroups it takes a lot of time to keep 
> current, and you see a lot of stuff you don't need.
> 

Does this resume to :
I want my company to be in control. And nobody else please, because i do not
trust them.
Who would you want in this security board ? No hackers i believe they have no
incentive to shut the *** up, they do not care about money or their buisness or
who knows why.

So you want :
a/ everyboddy is wrong, we cannot understand,
b/ crackers "are too lazy in many cases to read the high-level hacker boards"
c/ "How can i have fix without ever having a hole ?".
Close your eyes and believe, that s the only way to achieved absolute safety.
I am not kidding, billions of people does this, it seems efficient (only few
dies by accident).
d/ the world is mad , nobody cares about security except who we are in charge
(and have no power in the politics).
e/ i don t care who does the job but i want my god damn system to have no holes.

Sorry for this rude analysis . I assume you want :
1/ a way to be alerted of the security hole of your application stack , and
those only.
2/ fix before the script kiddies.

For one the fix is quite easy, it is a matter of getting security alerts in an
easy way (maybe newsletter are getting old, what about a web as amazon does for
stuff) and a filter on your application stack.

For two, nobody can help. Script kiddies does not even read tech lists. They do
not make the scripts. Those who made them usually don't just read ML, they read
source, even binaries.
And those who make a living of cracking usually do not tell anybody. No CERT
alert. The only hope is easy to read code, audit.

>And they are the real problem, because there 
> are so MANY of them, and they tend to do slash and burn stuff, wipe out 
> your files, steal your identity, and other things you have to notice. 
i bet you don't know what script kiddies is all about , those who want to stole
your identity does not fit there (neither XSS, pishing nor script kiddies
 relate to kernel devel in most case).

Afaik the problem discussed in this thread was not about customer as you and I
to be alerted but upstream to have the patch at the same time. And maybe for the
distribution to share patches faster.

About politics:
> With no disrespect, I don't believe you have ever been a full-time 
> employee system administrator for any commercial or government 
> organization, and I don't believe you have any experience trying to do 
> security

followed by :
> I think you are still missing the point, I don't care if a security firm 
> reads mailing lists or tea leaves, does research or just knows where to 
> find it, they are paid to do it and if they do it well and report the 
> problems which apply to me and the source of the fixes they keep me from 
> missing something and at the same time save me time.

been there done that. You cannot master security, be the sole administrator and
deal with internal company politics (and maybe provide scripts, macros and
documentation if time permits). This has nothing to do with the way the kernel
deal with security alerts. We are not only paid to secure everything and admin.
But to make choices and the right ones as ressources are limited.


You could look for debian kernel , you have fixes backported , so you do not
have to worry about a new feature breaking an app or an ABI change.
All server distributions does it. Most distributions also alert their users
about those security hole you should be warned about. Just subscribe to their
security ML.

About us as users of binaries, those problems are already resolved by 
distribution security teams. 

Cheers
Alban

