Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSAIWMV>; Wed, 9 Jan 2002 17:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289045AbSAIWML>; Wed, 9 Jan 2002 17:12:11 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:39575
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289043AbSAIWMA>; Wed, 9 Jan 2002 17:12:00 -0500
Date: Wed, 9 Jan 2002 16:56:58 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Doug McNaught <doug@wireboard.com>, linux-kernel@vger.kernel.org,
        greg@kroah.com, felix-dietlibc@fefe.de
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109165658.A31246@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Doug McNaught <doug@wireboard.com>, linux-kernel@vger.kernel.org,
	greg@kroah.com, felix-dietlibc@fefe.de
In-Reply-To: <200201092005.g09K5OL28043@snark.thyrsus.com> <m3n0zn6ysr.fsf@varsoon.denali.to> <20020109154425.A28755@thyrsus.com> <20020109230704.A25786@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020109230704.A25786@devcon.net>; from aferber@techfak.uni-bielefeld.de on Wed, Jan 09, 2002 at 11:07:04PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Ferber <aferber@techfak.uni-bielefeld.de>:
> Then add an init script and include installation of it to the
> installation steps of your autoconfigurator (it has to be installed
> anyway). If a distributor packages your program, he will include the
> init script into his package and enable it according to his init
> policy, or write an own init script, if your provided one doesn't
> fit.
> 
> That's the way it works for network daemons etc. for years.

This sounds like good advice.  The autoconfigurator is part of CML2,
which I expect to be distributed with the kernel.  Does that change 
your advice at all?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Those who make peaceful revolution impossible 
will make violent revolution inevitable."
	-- John F. Kennedy
