Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbSJYWNE>; Fri, 25 Oct 2002 18:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbSJYWNB>; Fri, 25 Oct 2002 18:13:01 -0400
Received: from bozo.vmware.com ([65.113.40.131]:38668 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261630AbSJYWM3>; Fri, 25 Oct 2002 18:12:29 -0400
Date: Fri, 25 Oct 2002 15:19:25 -0700
From: chrisl@vmware.com
To: Robert Love <rml@tech9.net>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
Message-ID: <20021025221925.GF1397@vmware.com>
References: <F2DBA543B89AD51184B600508B68D4000ECE7046@fmsmsx103.fm.intel.com> <1035582867.734.3953.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035582867.734.3953.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a strong preference to pick up between this two.

But please stick to the same name when this come to an conclusion.
I hate to put code said if  Redhat do this if SuSE do that
that kind of crap.

Thanks

Chris

PS, any idea will this available in 2.4 soon?

On Fri, Oct 25, 2002 at 05:54:26PM -0400, Robert Love wrote:
> On Fri, 2002-10-25 at 17:50, Nakajima, Jun wrote:
> 
> > Can you please change "siblings\t" to "threads\t\t". SuSE 8.1, for example,
> > is already doing it:
> 
> But RedHat apparently is using siblings.  2.4-ac also uses siblings.
> And I like "siblings" better so it wins in my opinion.
> 
> 	Robert Love
> 


