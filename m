Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292244AbSBOWkd>; Fri, 15 Feb 2002 17:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292239AbSBOWjZ>; Fri, 15 Feb 2002 17:39:25 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:13587
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292240AbSBOWh6>; Fri, 15 Feb 2002 17:37:58 -0500
Date: Fri, 15 Feb 2002 17:11:30 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>, Robert Love <rml@tech9.net>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215171130.C15406@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Robert Love <rml@tech9.net>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215213833.J27880@suse.de> <1013810923.807.1055.camel@phantasy> <20020215232832.N27880@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215232832.N27880@suse.de>; from davej@suse.de on Fri, Feb 15, 2002 at 11:28:32PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
>  Increased functionality I don't have a problem with, as long
>  as other more important things are addressed.  And for that matter,
>  Linus has said to Eric "I don't care, take this out of the
>  kernel completely leaving just oldconfig'. 
> 
>  It might just be the sanest choice, and leave all this discussion
>  in userland.

CML2 can live in userland.  It already does; three other projects use it.
The kernel rulebase cannot.  The real issue here is whether the CML1 
language carries sufficient information to support things like 
side-effect deduction.  And the answer is "no".
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
