Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbVGODxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbVGODxC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 23:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbVGODxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 23:53:02 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:14266 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263185AbVGODxA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 23:53:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k21UnKmUzQiXYJ2rRiPq6nWtickFmlZfn2WPNPEpB66OEJvca0DwTWcEFgOqc1hoBGOAndUSc4RIVimIXWEHB6NEy3Q+PD1JL2v2a0I/SvJffTEe2BC15tEqVdMc/jsiM+7m6vFYTpF39GF4egodfXps/5KGGLR5+iQ7po3k8Ds=
Message-ID: <2ea3fae105071420529c3e975@mail.gmail.com>
Date: Thu, 14 Jul 2005 20:52:58 -0700
From: yhlu <yinghailu@gmail.com>
Reply-To: yhlu <yinghailu@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: NUMA support for dual core Opteron
Cc: "Ronald G. Minnich" <rminnich@lanl.gov>,
       Stefan Reinauer <stepan@openbios.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050715030518.GS23737@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2ea3fae10507141058c476927@mail.gmail.com>
	 <Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov>
	 <20050714190929.GL23619@wotan.suse.de>
	 <2ea3fae1050714194649c66d7e@mail.gmail.com>
	 <20050715030518.GS23737@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

How do yo think about make x86-64 kernel support openfirmware interface?

Can we borrow some code from ppc64 arch?

YH


On 7/14/05, Andi Kleen <ak@suse.de> wrote:
> On Thu, Jul 14, 2005 at 07:46:49PM -0700, yhlu wrote:
> > p.s. can you use powernow when acpi is disabled?
> 
> Only on uniprocessor machines.
> 
> > p.s.s  Is powerpc64 support ACPI? or ACPI is only can be used by x86?
> 
> powerpc64 uses openfirmware, not ACPI.
> 
> -Andi
>
