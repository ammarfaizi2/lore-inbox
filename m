Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbVLNDDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbVLNDDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbVLNDDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:03:38 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:21224 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030263AbVLNDDi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:03:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BmlqrALATrmfjHQxGC3BlWWFVD3RvQTaj2VKEJZdDOISW/t8E6gUpzp8t7PdQxXTaafPnAPW1BINiGxo+6OzkJWvQyfpOyMbtjro+91vxSvHA1XCCwUVE/v9EcAnpzm1ITWSVA+57dL+yAJy60pIUFMaEx3q4BXhyl/Jt86B5uY=
Message-ID: <2cd57c900512131903i4b79b9e2k@mail.gmail.com>
Date: Wed, 14 Dec 2005 11:03:36 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Dave Jones <davej@redhat.com>,
       Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>,
       linux-kernel@vger.kernel.org, coywolf@gmail.com
Subject: Re: bugs?
In-Reply-To: <20051214022457.GA15716@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <439F79CE.6040609@ens.etsmtl.ca>
	 <20051214022457.GA15716@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/14, Dave Jones <davej@redhat.com>:
> On Tue, Dec 13, 2005 at 08:47:58PM -0500, Caroline GAUDREAU wrote:
>  > my cpu is 1400MHz, but why there's cpu MHz         : 598.593
>
>  > flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov
>  > pat clflush dts acpi mmx fxsr sse sse2 tm pbe est tm2
>                                                  ^^^
>
> Your CPU is speedstep capable.  Most modern distros include a daemon
> for adjusting CPU speed based upon load.

what daemon? suppose in debian or redhat.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
