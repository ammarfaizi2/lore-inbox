Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287882AbSAPVkV>; Wed, 16 Jan 2002 16:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287936AbSAPVhR>; Wed, 16 Jan 2002 16:37:17 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:18900 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S287940AbSAPVg7>; Wed, 16 Jan 2002 16:36:59 -0500
Message-Id: <200201161506.g0GF6Xjs001294@tigger.cs.uni-dortmund.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Tue, 15 Jan 2002 14:53:24 EST." <20020115145324.A5772@thyrsus.com> 
Date: Wed, 16 Jan 2002 16:06:33 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:
> The latest version is always available at <http://www.tuxedo.org/~esr/cml2/>.
> 
> Release 2.1.3: Tue Jan 15 14:41:45 EST 2002
> 	* Resync with 2.4.18-pre3 and 2.5.2.
> 	* It is now possible to declare explicit saveability predicates.
> 	* The `vitality' flag is gone from the language.  Instead, the 
> 	  autoprober detects the type of your root filesystem and forces
> 	  its symbol to Y.

Great! Now I can't configure a kernel for ext3 only on an ext2 box. Keep it
up! As it goes, we can safely forget about CML2...
-- 
Horst von Brand			     http://counter.li.org # 22616
