Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292181AbSBOVtv>; Fri, 15 Feb 2002 16:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292180AbSBOVtb>; Fri, 15 Feb 2002 16:49:31 -0500
Received: from ns.suse.de ([213.95.15.193]:38154 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292178AbSBOVt2>;
	Fri, 15 Feb 2002 16:49:28 -0500
Date: Fri, 15 Feb 2002 22:49:16 +0100
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215224916.L27880@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020215155817.A14083@thyrsus.com>; from esr@thyrsus.com on Fri, Feb 15, 2002 at 03:58:17PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 03:58:17PM -0500, Eric S. Raymond wrote:
 > Back-seat drivers.  Answers for everything, understanding of nothing.

 *plonk*

 > Sorry, it's not *nearly* that simple.  For one thing, one of the fourteen
 > billion requirements I've had dropped on me is that Marcelo doesn't want
 > any symbols in his help file that aren't actually in the 2.4 rulebase.

 As you obviously completely ignored my previous point, I'll reiterate it.

 1. You run Linus' split-into-config.in script on a 2.4 tree.
 2. You add whatever Config.ins have been updated to the 2.4 config.ins
 3. You regenerate with the find example I showed in the other mail.

 There. 2.4 Configure.help up to date with latest symbols, but
 containing none of the 2.5 ones.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
