Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292250AbSBOWnd>; Fri, 15 Feb 2002 17:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292242AbSBOWmP>; Fri, 15 Feb 2002 17:42:15 -0500
Received: from ns.suse.de ([213.95.15.193]:6159 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292240AbSBOWld>;
	Fri, 15 Feb 2002 17:41:33 -0500
Date: Fri, 15 Feb 2002 23:41:31 +0100
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215234131.O27880@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com> <20020215224916.L27880@suse.de> <20020215170459.A15406@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020215170459.A15406@thyrsus.com>; from esr@thyrsus.com on Fri, Feb 15, 2002 at 05:04:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 05:04:59PM -0500, Eric S. Raymond wrote:

 > And you've completely ignored the real problem...which is when I get
 > a text change for one tree, *how do I automatically propagate it to
 > the other*?  How do I *tell* that it ought to be propagated?  

 Depends on the context of the change.
 In a majority of cases the answer is RTFC.
 If this is too much effort, rethink your outlook on whats
 involved as 'maintainer' of something like the Config.help's.
 
 This is precisely the reason that splitting them was the best
 thing that could have happened. They are now maintained by
 the people who actually *know* whats involved, so you don't have to.

 > Solutions that involve me doing an arbitrary and increasing amount of
 > hand-hacking on every release are right out.
 
 Reading diffs and finding out why things changed, and following
 conversations on Linux-kernel are the only way you'll know if
 something is relevant in other trees. If you've a robot that can
 do this, I'm all ears, as it could save me hours each day.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
