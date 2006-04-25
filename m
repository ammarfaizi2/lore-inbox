Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWDYH4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWDYH4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWDYH4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:56:06 -0400
Received: from unthought.net ([212.97.129.88]:4368 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751408AbWDYH4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:56:05 -0400
Date: Tue, 25 Apr 2006 09:56:04 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Avi Kivity <avi@argo.co.il>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gary Poppitz <poppitzg@iomega.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-ID: <20060425075604.GP14981@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Avi Kivity <avi@argo.co.il>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Gary Poppitz <poppitzg@iomega.com>, linux-kernel@vger.kernel.org
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444D3D32.1010104@argo.co.il>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:03:46AM +0300, Avi Kivity wrote:
> Alan Cox wrote:
> >There are a few anti C++ bigots around too, but the kernel choice of C
> >was based both on rational choices and experimentation early on with the
> >C++ compiler.
> >  
> Times have changed, though. The C++ compiler is much better now, and the 
> recent slew of error handling bugs shows that C is a very unsafe language.
> 
> I think it's easy to show that the equivalent C++ code would be shorter, 
> faster, and safer.

Please read:
 http://unthought.net/c++/c_vs_c++.html

This explains, in simple terms, why you are just as right as you are
wrong.

Snippet:
-------------
Note, that I am not arguing that everything is rewritten in C++. There
are many large projects out there which are written in C - I do not
believe that it is a good idea to just "convert" them to C++. C++ allows
for cleaner solutions than C does, for a great many problems. Doing a
minimal conversion of a solution which is "as clean as it gets" in C, to
C++, would convert "good C" code into "poor C++". That is not a change
to the better!
-------------

And let's forget about this thread then please.

-- 

 / jakob

