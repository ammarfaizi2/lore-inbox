Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264217AbRFODu6>; Thu, 14 Jun 2001 23:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264228AbRFODus>; Thu, 14 Jun 2001 23:50:48 -0400
Received: from [204.244.205.22] ([204.244.205.22]:2573 "HELO apollo.wizard.ca")
	by vger.kernel.org with SMTP id <S264217AbRFODua>;
	Thu, 14 Jun 2001 23:50:30 -0400
Subject: Re: obsolete code must die
From: Michael Peddemors <michael@linuxmagic.com>
To: Claudio Martins <ctpm@vega.net.dhis.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01061402132900.00856@vega>
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x> 
	<01061402132900.00856@vega>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 14 Jun 2001 20:48:44 -0700
Message-Id: <992576924.4885.13.camel@mistress>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be drifting into that old argument(s) of a forked kernel..
And of course here I am adding to the flotsams..and threadsomes

2.5 for Pentium Plus generation.

<2.4 For older hardware..

Ducking the inevitable flames, I think for the most part, there might be
justification for some forking.. (read obsolesence)

Anyone with a <486 probably shudders at the space and time requirements
of compiling modern kernels.. All they need is the older kernels.. 
The older boxes don't support the new hardware anyways..
But then there is always someone who will find a way to marry a new PCI
or USB bus to an older CPU, and it is nice that 'one kernel to bind
them' philosophy of linux..

But in this age of 'disposability' more and more people just accept they
have to buy new hardware every 3-5 years.. For those that want to
maintain Linux on that, so be it..

Maybe we need more Alan Cox's, and then we could have sperate kernel
trees, Linus's which is the mmmmmother.. (HI MOM!) and the pre-pentium
tree, the post-pentium tree, the embedded tree etc..

But in reality, with all the people contributing now to one tree, there
is still more work to be done.. Who wants to split those resources?

But it is a legitimate argument...

In reality, hardware needs drive kernel upgrades.. and of course some
security issues.. Those who have older hardware aren't interested in
upgrading the kernel, why should they.. it is rock solid as it is..
And newer machines don't need support for the older hardware..

If you want to stay bleading edge kernel wise, usually you stay bleeding
edge hardware wise.. But it is nice the we now can apply the power of
iptables to older 486 firewalls..

BUT as much as it might be cleaner, and a little less headaches to drop
all the fluff that doesn't usually get used, is it worth dropping it
when all newer hardware doesn't care about a little bloat.. *cough* I
can't believe I just supported bloat..  Okay, me personally, I wouldn't
mind seeing tiny litle kernels and tiny little code trees, makes me feel
more effecient, and I don't get blurry eyes from grepping so much code..

(Personally sometimes I think all this new power is wasted in PC's is
wasted, but I have to admit.. these 10 second compiles vs the old 28
hour ones are nice)

On 14 Jun 2001 02:13:29 +0100, Claudio Martins wrote:
> On Thursday 14 June 2001 01:44, Daniel wrote:
> 
> > -- If someone really needs support for this junk, they will always have the
> > option of using the 2.0.x, 2.2.x or 2.4.x series.
> >
> 
>   You mean you want 2.5+ series to just stop supporting all older hardware?
-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
WizardInternet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada

