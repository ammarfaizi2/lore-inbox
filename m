Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273504AbRIYWNH>; Tue, 25 Sep 2001 18:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273457AbRIYWM6>; Tue, 25 Sep 2001 18:12:58 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:14086 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S273355AbRIYWMj>; Tue, 25 Sep 2001 18:12:39 -0400
Message-ID: <3BB101AE.C7CA4997@drugphish.ch>
Date: Wed, 26 Sep 2001 00:14:06 +0200
From: Roberto Nibali <ratz@drugphish.ch>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com> <20010925084439.B6396@us.ibm.com> <20010925200947.B7174@itsolve.co.uk> <20010925134232.A14715@kroah.com> <3BB0F297.D4A9E986@drugphish.ch> <20010925141623.A14962@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Thank you for putting this up.  It looks like they are placing hooks all
> through the kernel, much like the LSM patch does.

Yep, and I reckon that they could port their security module to the
LSM one within one week. I mentioned it to Peter Loscocco at OLS 2001 
at the LSM BOF.
 
> And since they are patching the kernel to provide hooks for their
> security module, they should also release that security module source
> code to remain legal.

I don't know about GPL and kernel related rights but I can hardly 
imagine a company that has a B1 certified product not to care well
about their other products to be on the right side of the law. I 
can talk to them on thursday about this at the comdex/orbit showcase.
The outcome of your legality statement might be crucial for their 
future business.

BTW, I recall the HP Linux which IMO also violates the GPL then, doesn't
it? http://www.hp.com/security/products/linux/opensource/
Or does this differ in them providing the source code even for the LKMs
as opposite to argus which has binary only LKMs?

> Thanks again.

No problem, regards,
Roberto Nibali, ratz
