Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbVLNDZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbVLNDZf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbVLNDZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:25:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7346 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030368AbVLNDZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:25:34 -0500
Date: Tue, 13 Dec 2005 22:25:18 -0500
From: Dave Jones <davej@redhat.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: bugs?
Message-ID: <20051214032518.GA3604@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Coywolf Qi Hunt <coywolf@gmail.com>,
	Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>,
	linux-kernel@vger.kernel.org
References: <439F79CE.6040609@ens.etsmtl.ca> <20051214022457.GA15716@redhat.com> <2cd57c900512131903i4b79b9e2k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900512131903i4b79b9e2k@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 11:03:36AM +0800, Coywolf Qi Hunt wrote:
 > 2005/12/14, Dave Jones <davej@redhat.com>:
 > > On Tue, Dec 13, 2005 at 08:47:58PM -0500, Caroline GAUDREAU wrote:
 > >  > my cpu is 1400MHz, but why there's cpu MHz         : 598.593
 > >
 > >  > flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov
 > >  > pat clflush dts acpi mmx fxsr sse sse2 tm pbe est tm2
 > >                                                  ^^^
 > >
 > > Your CPU is speedstep capable.  Most modern distros include a daemon
 > > for adjusting CPU speed based upon load.
 > 
 > what daemon? suppose in debian or redhat.

'cpuspeed' in Fedora/RHEL.  Debian probably offers a dozen different
ones most of which I've never heard of :)

		Dave



