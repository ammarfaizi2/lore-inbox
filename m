Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVCXJau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVCXJau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 04:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVCXJau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 04:30:50 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:10907 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261982AbVCXJak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 04:30:40 -0500
Date: Thu, 24 Mar 2005 04:30:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Asfand Yar Qazi <ay1204@qazi.f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
Message-ID: <20050324093032.GA14022@havoc.gtf.org>
References: <4242865D.90800@qazi.f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4242865D.90800@qazi.f2s.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 09:20:29AM +0000, Asfand Yar Qazi wrote:
> Hi,
> 
> I'm currently contemplating going for an Athlon 64 system.  However, 
> I'll primarily be using a Linux-based OS (Gentoo, namely), so I need 
> to know how well the chipsets are supported currently.
> 
> I'd really like to go Via - but the crummy KT890 / VT8237 combo sucks 
> - mainly due to the lack of SATA II with NCQ.  I share the sentiments 
> of the person in a post in the AnandTech forums 
> (http://tinyurl.com/6d9bx) who says:
> 
> "The feature set on the K8T890 sucks. It was supposed to use the 
> VT8251 southbridge, bringing SATA-II/NCQ, HD Audio, etc. 
> Unfortunately, this southbridge has since dissappeared off the face of 
> the earth, and all the current K8T890 boards use the old VT8237. 
> nForce4, on the other hand, has SATA-II/NCQ, hardware firewall, nice 
> software overclocking/monitoring tools (ntune), gigabit lan, etc. On 
> top of that, performance and overclocking is pretty damn good. I was 
> at one point looking forward to the K8T890, but considering how much 
> of a joke the whole product line has been (lacking features, months of 
> delays with no explanation, lack of any variety of retail boards), I 
> have to say I'd avoid it like the plague."

Well, let's cut through the B.S. ;-)

* Even when the SATA core is updated to support NCQ, nForce will not
support it under Linux.  No hardware info.

* "hardware firewall" -- sounds silly.  Pretty sure Linux doesn't support
it in any case.

* overclocking -- overclockers are always playing with fire.  any
overclocked hardware is suspect and unsupportable.

* via comes with gigabit lan these days.  My own VIA-based Athlon64
system comes with r8169 gigabit.

	Jeff



