Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291320AbSBGVaR>; Thu, 7 Feb 2002 16:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291321AbSBGVaG>; Thu, 7 Feb 2002 16:30:06 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:9618 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291320AbSBGV30>;
	Thu, 7 Feb 2002 16:29:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Touloumtzis <miket@bluemug.com>
Subject: Re: How to check the kernel compile options ?
Date: Thu, 7 Feb 2002 22:33:41 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <E16YvYs-00015d-00@starship.berlin> <20020207210823.GH26826@bluemug.com>
In-Reply-To: <20020207210823.GH26826@bluemug.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16YwAn-000169-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2002 10:08 pm, Mike Touloumtzis wrote:
> On Thu, Feb 07, 2002 at 09:54:30PM +0100, Daniel Phillips wrote:
> > On February 7, 2002 09:34 pm, Mike Touloumtzis wrote:
> > > Some possible available avenues of argument for you are:
> > 
> > I think you're just arguing for the sake of argument, which basically sums
> > up all the arguments we've seen against this.
> 
> Not at all.  I really believe that embedded unnecessary information in
> the kernel is a bad idea.  I don't want my kernels to get any bigger
> than they are now unless useful features are being added (I have no
> problem with that).  I develop for embedded devices, so I'm particularly
> sensitive to this issue.

I've heard that one before, from people who should know better.  That's what 
config options are for, or it's certainly a major reason for having config 
options.  Heck, I'd be satisfied if it was off by default.  I'd *always* turn 
it on, personally.

> My understanding is that "keep features out of the kernel if possible"
> is the majority opinion, not a crackpot weirdo stance.

Right, but would you buy a car without upholstery on the seats?  Wait, maybe 
you would.

> > Let me put it in simple terms: you've got an alarm clock, haven't you?  
> > When you set the alarm, you don't need to have any little light on the 
> > front that tells you the alarm is set, do you?  Because, after all you're 
> > not stupid, you know you set it.  And you can always get out of bed and 
> > look at the position of the switch, right?
> 
> I don't think this is a close enough analogy to illustrate anything.

Right, it's tough to explain usability to someone who has no clue what that 
is.

OK, I'm out, I've made my point, you are welcome to attempt to demolish it 
without fear of retaliation.

-- 
Daniel
