Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRIQPBn>; Mon, 17 Sep 2001 11:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRIQPBe>; Mon, 17 Sep 2001 11:01:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:40901 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268861AbRIQPBY>; Mon, 17 Sep 2001 11:01:24 -0400
Message-ID: <3BA61054.9C82042B@vnet.ibm.com>
Date: Mon, 17 Sep 2001 15:01:40 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tom Rini <trini@kernel.crashing.org>, paulus@samba.org,
        rusty@rustcorp.com.au
Subject: Re: [PATCH] bzImage target for PPC
In-Reply-To: <E15ipks-0006sS-00@wagner> <20010916212538.F14279@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> On Mon, Sep 17, 2001 at 02:11:34PM +1000, Rusty Russell wrote:
> 
> > All the instructions (including the message after "make oldconfig")
> > talk about "make bzImage".  So I suppose it's best to give in to this
> > rampant Intelism 8)
> 
> What about 'bzlilo' and 'zlilo' ? Those are mentioned too.  Linus, please
> don't apply this.  Hopefully Paul will say that too. :)

I'm with Tom on this. Don't apply this one. Additionally in the ppc64 camp we
like our ppc brothern have been sticking with zImage. It seems (least to me)
that it's reasonably documented in ppc and ppc64 circles. Perhaps tho it would
be appropriate to add a short little blurb in the  README for the various
architectures.

> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

Regards,

Tom

-- 
Tom Gall - PPC64 Code Monkey     "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
