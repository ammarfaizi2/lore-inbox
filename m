Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWBQURw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWBQURw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWBQURw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:17:52 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:9491 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750765AbWBQURv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:17:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dUD53ImdsBjBOrmsFSAexqbdH8StGIJi2zwl1TlzOVmBCcZA+EWS9WfPw1CJpOtS2AW/Dl8ctEBCalK8SCHCWubVnNnHh9cpU1eRaceD4bhVMyHXgFHhvTEaqb1ODR8hkfmCmrCmLXH2OPfSs+A7UCn1Lqwhv9Wcqj2ndaOoKVw=
Message-ID: <cde01ae70602171217h2b1b32f8s5deab06ac8573795@mail.gmail.com>
Date: Fri, 17 Feb 2006 21:17:49 +0100
From: Lz <elezeta@gmail.com>
To: "Adam Belay" <ambx1@neo.rr.com>, Lz <elezeta@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Problems with sound on latest kernels.
In-Reply-To: <20060217195610.GC18338@neo.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cde01ae70602140558g6440af40mf59e3e1992088d3b@mail.gmail.com>
	 <1139934640.11659.95.camel@mindpipe>
	 <20060214232222.1016fe87.akpm@osdl.org>
	 <cde01ae70602150542m1b57aa83l62508927276241b@mail.gmail.com>
	 <20060217061701.GA17208@neo.rr.com>
	 <cde01ae70602170831h43668a5ay3a3e4f0ce446c241@mail.gmail.com>
	 <20060217195610.GC18338@neo.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm really sure they're the same options... isapnp enabled and both
alsa and oss compiled (in that config i had both compiled, because i
did not know if the problem was related to alsa).

On 2/17/06, Adam Belay <ambx1@neo.rr.com> wrote:
> On Fri, Feb 17, 2006 at 05:31:27PM +0100, Lz wrote:
> > Hello, it seems to be fixed at the latests git-.
> >
> > Do you still need me to try that patch?
>
> Are you sure you're using the same kconfig options?  For example, is isapnp
> now disabled, or are you using the ALSA driver instead of the OSS driver
> (appears as "sb" in the kernel log)?
>
> Thanks,
> Adam
>


--
Lz (elezeta@gmail.com).
http://elezeta.bounceme.net
