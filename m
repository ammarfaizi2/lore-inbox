Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287283AbSBPHCz>; Sat, 16 Feb 2002 02:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289761AbSBPHCp>; Sat, 16 Feb 2002 02:02:45 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:46085
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287283AbSBPHCj>; Sat, 16 Feb 2002 02:02:39 -0500
Date: Sat, 16 Feb 2002 01:35:38 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Rob Landley <landley@trommello.org>
Cc: Dave Jones <davej@suse.de>, Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216013538.A23546@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Rob Landley <landley@trommello.org>, Dave Jones <davej@suse.de>,
	Larry McVoy <lm@work.bitmover.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <20020215224916.L27880@suse.de> <20020215170459.A15406@thyrsus.com> <20020215232517.FXLQ71.femail38.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215232517.FXLQ71.femail38.sdc1.sfba.home.com@there>; from landley@trommello.org on Fri, Feb 15, 2002 at 06:26:06PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org>:
> On Friday 15 February 2002 05:04 pm, Eric S. Raymond wrote:
> 
> > Solutions that involve me doing an arbitrary and increasing amount of
> > hand-hacking on every release are right out.
> 
> Um, Eric?  Isn't that what being a maintainer basically means?

The problem isn't that I'm not willing to work hard. I am.  It's that
the level of handhacking has to be controlled below the threshold that
makes it impossible.

> Back up a bit.  What would be the most minimal, stripped-down version of CML2
> you could write?  No eye candy, no complications, no autoconfigurator, no 
> tree view, no frozen symbols.  Just solving the core problem of configuring 
> 2.5 in a more flexible and less buggy way than CML1, with the three 
> interfaces (oldconfig, menuconfig, xconfig) we've got now.

The big problem isn't the code transition.  It's the rulebase transition.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
