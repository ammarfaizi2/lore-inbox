Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSBOVPu>; Fri, 15 Feb 2002 16:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292134AbSBOVPp>; Fri, 15 Feb 2002 16:15:45 -0500
Received: from ns.suse.de ([213.95.15.193]:35079 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292130AbSBOVPe>;
	Fri, 15 Feb 2002 16:15:34 -0500
Date: Fri, 15 Feb 2002 22:15:32 +0100
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215221532.K27880@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020215153953.D12540@thyrsus.com>; from esr@thyrsus.com on Fri, Feb 15, 2002 at 03:39:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 03:39:53PM -0500, Eric S. Raymond wrote:

 > As a result, I had to tell Marcelo I had no choice but to drop maintaining
 > the 2.4 help file.  The divergence, and the damage, is probably not
 > recoverable.

 find . -name Config.help -exec cat {} >Configure.help \;

 Ok, they'll perhaps not be in the same order as your original
 working set, but that issue goes away when you split your
 set up with the tools Linus gave you, and regenerate.
 
 Maintaining is hard, lets go shopping.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
