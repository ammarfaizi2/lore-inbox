Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKIHxb>; Thu, 9 Nov 2000 02:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKIHxW>; Thu, 9 Nov 2000 02:53:22 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:64824
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S129057AbQKIHxO>; Thu, 9 Nov 2000 02:53:14 -0500
Date: Wed, 8 Nov 2000 23:53:12 -0800
From: Larry McVoy <lm@bitmover.com>
To: Christoph Rohland <cr@sap.com>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Message-ID: <20001108235312.H22781@work.bitmover.com>
Mail-Followup-To: Christoph Rohland <cr@sap.com>,
	Michael Rothwell <rothwell@holly-springs.nc.us>,
	richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <80256991.007632DE.00@d06mta06.portsmouth.uk.ibm.com> <3A09C725.6CFA0EE2@holly-springs.nc.us> <qwwn1f9lhdg.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <qwwn1f9lhdg.fsf@sap.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 08:44:11AM +0100, Christoph Rohland wrote:
> Hi Michael,
> 
> On Wed, 08 Nov 2000, Michael Rothwell wrote:
> > Sounds great; unfortunately, the core group has spoken out against a
> > modular kernel.
> > 
> > Perhaps IBM should get together with SGI, HP and other interested
> > parties and start an Advanced Linux Kernel Project. Then they can
> > run off and make their scalable, modular, enterprise kernel and the
> > Linus Version can always merge back in features from it.
> 
> *Are you crazy?* =:-0 
> 
> Proposing proprietary kernel extensions to establish an enterprise
> kernel? No thanks!

Actually, I think this idea is a good one.  I'm a big opponent of all the
big iron feature bloat getting into the kernel, and if SGI et al want to
go off and do their own thing, that's fine with me.  As long as Linus 
continues in his current role, I doubt much of anything that the big iron
boys do will really make it back into the generic kernel.  Linus is really
smart about that stuff, are least it seems so to me; he seems to be well
aware that 99.9999% of the hardware in the world isn't big iron and never
will be, so something approximating 99% of the effort should be going towards
the common platforms, not the uncommon ones.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
