Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312917AbSD2RAZ>; Mon, 29 Apr 2002 13:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312920AbSD2RAY>; Mon, 29 Apr 2002 13:00:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:9186 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312917AbSD2RAX>;
	Mon, 29 Apr 2002 13:00:23 -0400
Subject: Re: The tainted message
From: Brian Beattie <alchemy@us.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Richard Thrapp <rthrapp@sbcglobal.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1019926629.2045.698.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 Apr 2002 09:59:40 -0700
Message-Id: <1020099580.5131.14.camel@w-beattie1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-27 at 09:57, Robert Love wrote:
> On Sat, 2002-04-27 at 11:20, Alan Cox wrote:
> 
> > How about
> > 
> > Warning: The module you have loaded (%s) does not seem to have an open
> > 	 source license. Please send any kernel problem reports to the
> > 	 author of this module, or duplicate them from a boot without
> > 	 ever loading this module before reporting them to the community
> > 	 or your Linux vendor
> 
> Perfect.  A little long, but otherwise nails it.
> 
Warning: The module (%s) does not seem to have a compatible license.
         Please contact the supplier of this module regarding any
         problems, or reproduce the problem after rebooting without
         ever loading this module.

shorter?

> Maybe we want to s/open source/GPL-compatible/ though?
> 
> 	Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


