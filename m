Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292378AbSBPO0Z>; Sat, 16 Feb 2002 09:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292379AbSBPO0G>; Sat, 16 Feb 2002 09:26:06 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:45575
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292378AbSBPOZ6>; Sat, 16 Feb 2002 09:25:58 -0500
Date: Sat, 16 Feb 2002 08:57:06 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Rob Landley <landley@trommello.org>, Dave Jones <davej@suse.de>,
        Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216085706.H23546@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Rob Landley <landley@trommello.org>, Dave Jones <davej@suse.de>,
	Larry McVoy <lm@work.bitmover.com>,
	Arjan van de Ven <arjan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020216013538.A23546@thyrsus.com> <20020215135557.B10961@thyrsus.com> <20020215224916.L27880@suse.de> <20020215170459.A15406@thyrsus.com> <20020215232517.FXLQ71.femail38.sdc1.sfba.home.com@there> <20020216013538.A23546@thyrsus.com> <22614.1013851279@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <22614.1013851279@redhat.com>; from dwmw2@infradead.org on Sat, Feb 16, 2002 at 09:21:19AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> However - the thing to which I and many others object most strongly is the 
> rulebase policy changes which appear to be inseparable from the change in 
> mechanism. That is; we've tried to get you to separate them, and failed.

Failed?  Hardly.

The only rulebase policy change Tom Rini was able to identify in a recent
review was the magic behavior of EXPERT with respect to entries without
help.  Which I then removed by commenting out a single declaration.

There is a widespread myth that the CML2 rulebase is lousy with "policy
changes".  I don't know how it got started, but it needs to die now.

Maybe I need to write a CML2 FAQ.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
