Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280994AbRLDQle>; Tue, 4 Dec 2001 11:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbRLDQlY>; Tue, 4 Dec 2001 11:41:24 -0500
Received: from t2.redhat.com ([199.183.24.243]:56061 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S280961AbRLDQlV>; Tue, 4 Dec 2001 11:41:21 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011204111115.A15160@thyrsus.com> 
In-Reply-To: <20011204111115.A15160@thyrsus.com>  <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de> 
To: esr@thyrsus.com
Cc: Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Dec 2001 16:41:02 +0000
Message-ID: <19642.1007484062@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  You can spend all week telling us how easy it would be to implement
> all the CML2 benefits that CML1 doesn't have, if you like -- but one
> of the rules of this game is that an ounce of working code beats a
> pound of handwaving. 

FWIW I have no particular problem with CML2. I agree that CML1 is fairly 
limited, and can see the advantages in ditching it for a new language.

I do have objections to some of the other ideas which have been floated for
changing the behaviour of the config rules, which aren't strictly related to
the change in language. 

I just want to make sure that the introduction of CML2 doesn't sneak in
controversial changes to the config behaviour to make my Aunt Tilley happy, 
when those changes should be given individual consideration, not presented 
as a fait accomplis.

If I can't have one without the other, I'd rather not have either - CML1 
may indeed suck, but it doesn't suck _that_ much.

But I figure we can trust you not to do that - can't we?

--
dwmw2


