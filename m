Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUCJT7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbUCJT7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:59:48 -0500
Received: from emn-agsl-4744.mxs.adsl.euronet.nl ([212.129.199.68]:51217 "EHLO
	kapteyn.telox.net") by vger.kernel.org with ESMTP id S262689AbUCJT7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:59:43 -0500
Date: Wed, 10 Mar 2004 20:49:02 +0100
From: Wouter Lueks <wouter@telox.net>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
Message-ID: <20040310194902.GB8375@telox.net>
References: <20040308061802.GA25960@cup.hp.com> <16460.49761.482020.911821@napali.hpl.hp.com> <404CEA36.2000903@pacbell.net> <16461.35657.188807.501072@napali.hpl.hp.com> <404E00B5.5060603@pacbell.net> <16462.1463.686711.622754@napali.hpl.hp.com> <404E2B98.6080901@pacbell.net> <16462.48341.393442.583311@napali.hpl.hp.com> <20040310075211.GA8375@telox.net> <16463.18183.341946.76971@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16463.18183.341946.76971@napali.hpl.hp.com>
X-Operating-System: Linux kapteyn 2.6.3 #1 Sat Mar 6 10:06:04 CET 2004 i686 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 08:49:11AM -0800, David Mosberger wrote:
> >>>>> On Wed, 10 Mar 2004 08:52:12 +0100, Wouter Lueks <wouter@telox.net> said:
>   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107889747301413
> 
>   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107889855108618
> 
> I'd be interested in hearing if that fixes the problems for your machine.

I applied both patches and it workes fine now, the keyboard gets
recognised withouth any further problems.

Wouter Lueks
