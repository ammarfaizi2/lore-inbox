Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292122AbSBOVGk>; Fri, 15 Feb 2002 16:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292123AbSBOVGb>; Fri, 15 Feb 2002 16:06:31 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:64017
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292122AbSBOVGU>; Fri, 15 Feb 2002 16:06:20 -0500
Date: Fri, 15 Feb 2002 15:39:53 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215153953.D12540@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215124255.F28735@work.bitmover.com>; from lm@bitmover.com on Fri, Feb 15, 2002 at 12:42:55PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com>:
> Gimme a break.  I read those posts, I repeatedly saw that people said to do 
> that, I don't remember if it was Linus or not, but it's not like he has the
> only brain.  The clearly expressed sentiment was to put the help next to the
> source.  You repeatedly came up with corner cases where that wouldn't work
> and used that as an excuse to do nothing.

And one of those corner cases in fact came around and bit us on the ass.

If we had handled the transition the smooth way I wanted to, and was
prepared to, we'd still have a maintainable help database spanning 2.4
as well as 2.5.  As it is, Linus blew my system into flinders and 
obsoleted all my tools (I'm not talking CML2 itself now but the machinery I
wrote for tracking help changes).

As a result, I had to tell Marcelo I had no choice but to drop maintaining
the 2.4 help file.  The divergence, and the damage, is probably not
recoverable.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
