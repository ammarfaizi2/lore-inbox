Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273619AbRIYWUh>; Tue, 25 Sep 2001 18:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273609AbRIYWUU>; Tue, 25 Sep 2001 18:20:20 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:18955 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S273596AbRIYWT5>;
	Tue, 25 Sep 2001 18:19:57 -0400
Date: Tue, 25 Sep 2001 15:15:51 -0700
From: Greg KH <greg@kroah.com>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010925151551.D15314@kroah.com>
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com> <20010925084439.B6396@us.ibm.com> <20010925200947.B7174@itsolve.co.uk> <20010925134232.A14715@kroah.com> <3BB0F297.D4A9E986@drugphish.ch> <20010925141623.A14962@kroah.com> <3BB101AE.C7CA4997@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB101AE.C7CA4997@drugphish.ch>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 12:14:06AM +0200, Roberto Nibali wrote:
> 
> I don't know about GPL and kernel related rights but I can hardly 
> imagine a company that has a B1 certified product not to care well
> about their other products to be on the right side of the law. I 
> can talk to them on thursday about this at the comdex/orbit showcase.
> The outcome of your legality statement might be crucial for their 
> future business.

Yes, the LSM licensing issue seems to be critical to a lot of people :)
Presently I am waiting for a response from WireX as to what their stance
is.

> BTW, I recall the HP Linux which IMO also violates the GPL then, doesn't
> it? http://www.hp.com/security/products/linux/opensource/
> Or does this differ in them providing the source code even for the LKMs
> as opposite to argus which has binary only LKMs?

Exactly.  It looks like HP provides the source code for everything
(someone tell me if I'm wrong here) while Argus looks like they only
provide the kernel patches and a compiled loadable module binary, under
a unknown license (at this time.)

thanks,

greg k-h
