Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264582AbRFTTmm>; Wed, 20 Jun 2001 15:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264585AbRFTTmc>; Wed, 20 Jun 2001 15:42:32 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:28942 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S264582AbRFTTmY>;
	Wed, 20 Jun 2001 15:42:24 -0400
Date: Wed, 20 Jun 2001 13:42:21 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Threads FAQ entry incomplete
Message-ID: <20010620134221.C12357@qcc.sk.ca>
In-Reply-To: <20010620104800.D1174@w-mikek2.des.beaverton.ibm.com> <lx66drf04u.fsf@pixie.isr.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <lx66drf04u.fsf@pixie.isr.ist.utl.pt>; from yoda@isr.ist.utl.pt on Wed, Jun 20, 2001 at 07:59:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rodrigo Ventura <yoda@isr.ist.utl.pt> wrote:
> 
> BTW, I have a question: Can the availability of dual-CPU boards for intel
> and amd processors, rather then tri- or quadra-CPU boards, be explained with
> the fact that the performance degrades significantly for three or more CPUs?
> Or is there a technological and/or comercial reason behind?

Commercial reasons.  Cost per motherboard/chipset goes way up as the number of
CPUs supported goes up.  For each CPU that a chipset supports, it has to add a
lot of pins/lands, and chipsets are already typically land-limited.
Motherboard trace complexity (and therefore number of layers) goes up.  Add to
that that the potential market goes down as CPUs goes up.

You can buy 4-, 8-, and 16-way motherboards for Intel CPUs (don't know about
more).  But the 16-way ones will cost as much as a house.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
Any opinions expressed are just that -- my opinions.
-----------------------------------------------------------------------
