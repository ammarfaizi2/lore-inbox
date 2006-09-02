Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWIBBk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWIBBk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 21:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWIBBk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 21:40:26 -0400
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:63905 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S1750799AbWIBBkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 21:40:25 -0400
Subject: Re: Linux v2.6.18-rc5
From: Elias Holman <eholman@holtones.com>
Reply-To: eholman@holtones.com
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jeff@garzik.org
In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	 <20060827231421.f0fc9db1.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 20:40:01 -0500
Message-Id: <1157161201.3679.6.camel@parachute.holtones.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Elias Holman <eholman@holtones.com>
> Subject: PROBLEM: PCI/Intel 82945 trouble on Toshiba M400 notebook

I can successfully boot my M400 under 2.6.18-rc5.  Even better, I can
now enable hotpluggable CPUs and successfully suspend and resume.  I
needed the SATA patch (http://lkml.org/lkml/2006/7/20/56), referenced in
the "T60 not coming out of suspend to RAM" thread as well, so I would
like to second Michael Tsirkin's request that this be merged in.

-- 
Eli



-- 
VGER BF report: H 0.137978
