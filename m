Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSAQCIK>; Wed, 16 Jan 2002 21:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288089AbSAQCH7>; Wed, 16 Jan 2002 21:07:59 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:56194
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288086AbSAQCHn>; Wed, 16 Jan 2002 21:07:43 -0500
Date: Wed, 16 Jan 2002 20:51:19 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Ross Vandegrift <ross@willow.seitz.com>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2-2.1.4 is available
Message-ID: <20020116205119.A23383@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Ross Vandegrift <ross@willow.seitz.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020116145605.A10792@thyrsus.com> <20020116175014.A21277@willow.seitz.com> <20020116174340.A16302@thyrsus.com> <20020116180042.A21447@willow.seitz.com> <20020116180112.C16592@thyrsus.com> <20020116200240.B22161@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020116200240.B22161@willow.seitz.com>; from ross@willow.seitz.com on Wed, Jan 16, 2002 at 08:02:40PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Vandegrift <ross@willow.seitz.com>:
> Sorry, didn't mean to be so terse.  Same as before - 'make config' or 'make
> menuconfig', press enter upon being shown the main menu while the default
> selection is "Intel or Processor type (FROZEN)".

Got it.  Looks like a bug I introduced when I filled someone else's request
to make frozen symbols invisible two point releases ago.  I should have it
fixed tonight.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The danger (where there is any) from armed citizens, is only to the
*government*, not to *society*; and as long as they have nothing to
revenge in the government (which they cannot have while it is in their
own hands) there are many advantages in their being accustomed to the 
use of arms, and no possible disadvantage.
        -- Joel Barlow, "Advice to the Privileged Orders", 1792-93
