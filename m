Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQL0QmI>; Wed, 27 Dec 2000 11:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbQL0Ql7>; Wed, 27 Dec 2000 11:41:59 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:18695 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S129664AbQL0Qlu>;
	Wed, 27 Dec 2000 11:41:50 -0500
Date: Wed, 27 Dec 2000 11:10:50 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Giacomo A. Catenazzi" <cate@student.ethz.ch>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@torque.net
Subject: Re: [KBUILD] How do we handle autoconfiguration?
Message-ID: <20001227111050.B8597@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Giacomo A. Catenazzi" <cate@student.ethz.ch>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org, linux-kbuild@torque.net
In-Reply-To: <200012262313.eBQNDBi07719@snark.thyrsus.com> <3A49CF1C.19A0FB55@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A49CF1C.19A0FB55@student.ethz.ch>; from cate@student.ethz.ch on Wed, Dec 27, 2000 at 12:14:36PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo A. Catenazzi <cate@student.ethz.ch>:
> I've difficult to merge with the CML1/2:
> 
> In CML2-0.8.3 the include frozen flag (-I) is broken, and
> also the new -W flag is broken, thus no real test.

0.9.0 fixes the -W flag.  I wasn't able to reproduce your problem with -I.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Men trained in arms from their infancy, and animated by the love of liberty,
will afford neither a cheap or easy conquest.
        -- From the Declaration of the Continental Congress, July 1775.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
