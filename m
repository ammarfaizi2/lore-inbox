Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290012AbSAPWEd>; Wed, 16 Jan 2002 17:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289859AbSAPWEK>; Wed, 16 Jan 2002 17:04:10 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:42625
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289568AbSAPWDy>; Wed, 16 Jan 2002 17:03:54 -0500
Date: Wed, 16 Jan 2002 16:47:58 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020116164758.F12306@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <esr@thyrsus.com> <200201162156.g0GLukCj017833@tigger.cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201162156.g0GLukCj017833@tigger.cs.uni-dortmund.de>; from brand@jupiter.cs.uni-dortmund.de on Wed, Jan 16, 2002 at 10:56:46PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <brand@jupiter.cs.uni-dortmund.de>:
> Whatever happened to "Do exactly as CML1 does; leave fixes and extensions
> for later"? If you put the kitchen sink into it, it _won't_ go into the
> standard kernel.

If you stick to the CML1-equivalent facilities, you'll get almost
CML1-equivalent behavior.  It's "almost" partly because the hardware symbols
have more platform- and bus-type guards than they used to -- but mostly
because I have not emulated the numerous CML1 bugs. 
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The people cannot delegate to government the power to do anything
which would be unlawful for them to do themselves.
	-- John Locke, "A Treatise Concerning Civil Government"
