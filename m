Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVLNCZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVLNCZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVLNCZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:25:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40334 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030243AbVLNCZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:25:08 -0500
Date: Tue, 13 Dec 2005 21:24:57 -0500
From: Dave Jones <davej@redhat.com>
To: Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>
Cc: linux-kernel@vger.kernel.org, coywolf@gmail.com
Subject: Re: bugs?
Message-ID: <20051214022457.GA15716@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>,
	linux-kernel@vger.kernel.org, coywolf@gmail.com
References: <439F79CE.6040609@ens.etsmtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439F79CE.6040609@ens.etsmtl.ca>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 08:47:58PM -0500, Caroline GAUDREAU wrote:
 > my cpu is 1400MHz, but why there's cpu MHz         : 598.593

 > flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov 
 > pat clflush dts acpi mmx fxsr sse sse2 tm pbe est tm2
                                                 ^^^

Your CPU is speedstep capable.  Most modern distros include a daemon
for adjusting CPU speed based upon load.

		Dave

