Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312842AbSCVUxW>; Fri, 22 Mar 2002 15:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312843AbSCVUxM>; Fri, 22 Mar 2002 15:53:12 -0500
Received: from [195.163.186.27] ([195.163.186.27]:24972 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S312842AbSCVUxG>;
	Fri, 22 Mar 2002 15:53:06 -0500
Date: Fri, 22 Mar 2002 22:53:05 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: ORBZ is dead, don't use it...
Message-ID: <20020322225305.B27741@mea-ext.zmailer.org>
In-Reply-To: <20020322221632.A27741@mea-ext.zmailer.org> <200203222045.g2MKja003931@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 01:45:36PM -0700, Richard Gooch wrote:
> Matti Aarnio writes:
> > We have been dropping people because they use now dead ORBZ:
> > 
> >     Rejected - see http://orbz.org/
> > 
> > The problem with these DNS-RBL things is that they are subject to
> > all kinds of external pressures, and apparently ORBZ has followed
> > ORBS in this manner.
> 
> Interesting. When I try to lookup hosts using orbz.org, I just get
> Non-existent host/domain results (thus mail shouldn't bounce). Why are
> some people bouncing email?

  I see both DNS lookup timeouts, and SERVFAIL returns.
  In my books neither should lead to rejection, but
  a) others may have better wisdom that I have,
  b) some popular software are known to be unable to
     separate any sort of temporary failures (timeouts
     at DNS lookup) from real things (actual DNS-RBL)

> 				Regards,
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca

/Matti Aarnio
