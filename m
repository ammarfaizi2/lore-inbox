Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288784AbSA2FPS>; Tue, 29 Jan 2002 00:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSA2FPI>; Tue, 29 Jan 2002 00:15:08 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:7563
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288784AbSA2FOx>; Tue, 29 Jan 2002 00:14:53 -0500
Message-Id: <200201290515.g0T5ExU32452@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: John Weber <weber@nyc.rr.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 00:15:55 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3C5600A6.3080605@nyc.rr.com>
In-Reply-To: <3C5600A6.3080605@nyc.rr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 January 2002 08:53 pm, John Weber wrote:
> I would be happy to serve as patch penguin, as I plan on collecting all
> patches anyway in my new duties as maintainer of www.linuxhq.com.
>
> I am currently writing code to scan the usual places for linux patches
> and automatically add them to our databases.  This would be really
> simplified by having patches sent to us.  And, since we already have a
> functioning site, we have the hardware/network capacity to serve as
> a limitless queue of waiting patches for Linus.  I would love nothing
> more than to update the site with information as to the status of these
> patches.
>
> ( john.weber@linux.org )

Philosophical question: Would you have a major philosophical objection to 
acting as Dave Jones's secretary and webmaster?  (He is the de facto current 
patch penguin.  I'm just asking for the position to be recognized.  We need 
that before we can really move forward with anything else.  If you were to 
queue patches for Linus and then be ignored by Linus, nothing would have been 
accomplished, and if somebody ELSE then takes your work and integrates it, it 
would be yet more pressure to fork the tree, pressure which I'm trying to 
REDUCE here...)

Remember minix?  Way way way back?  Andrew Tanenbaum had a little kernel, ran 
on intel hardware, came with complete source code.  And he did not accept 
patches, due to his minix book contract and the resulting licensing issues.  
Collaborative development on Linux STARTED in the minix newsgroup, largely by 
recruiting people who were frustrated at trying to get their patches into 
minix.

Remember GNU?  Stalled in the late 80's?  For legal reasons, Richard Stallman 
wanted people to physically sign over their copyrights (on paper he could put 
in his file cabinet) to any code they submitted to the GNU project.  This 
caused way too much friction (and Richard wasn't exactly a coalition building 
statesman either), and eventually people got fed up with the project and took 
their code elsewhere.

These are the kind of pressures that, if they build up high enough, cause 
projects to fork.  It's all different trees with different patches in them, 
and if the patch pressure builds up too high forking is inevitable.  
(Re-integration of forks is also quite possible, they can be short lived.  
But that's the same integration issue, just deferred a bit.)

I'm not saying Linux is in immediate danger of forking, I'm just saying that 
code integration can be a serious limiting factor, and is a potentially 
seperable problem from being a code architect.  I think an explicit full-time 
integration maintainer could reduce/buffer the patch pressure, and that this 
could be good for the project.

Rob
