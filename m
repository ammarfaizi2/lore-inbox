Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWFQFnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWFQFnS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 01:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWFQFnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 01:43:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27839 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750878AbWFQFnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 01:43:18 -0400
Date: Sat, 17 Jun 2006 01:43:07 -0400
From: Dave Jones <davej@redhat.com>
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AGPGART: unable to get memory for graphics translation table.
Message-ID: <20060617054307.GB8328@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ian Kent <raven@themaw.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0606171125390.2748@raven.themaw.net> <20060617034633.GC2893@redhat.com> <Pine.LNX.4.64.0606171201280.2812@raven.themaw.net> <20060617044625.GA8328@redhat.com> <Pine.LNX.4.64.0606171315220.2812@raven.themaw.net> <Pine.LNX.4.64.0606171323100.2433@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606171323100.2433@raven.themaw.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 01:24:58PM +0800, Ian Kent wrote:

 > Linux raven.themaw.net 2.6.16-1.2289_FC6xen #1 SMP Thu Jun 15 14:48:53 EDT 
                                           ^^^

I'll bet xen is to blame.  Can you try it on a plain kernel.org kernel?

		Dave

-- 
http://www.codemonkey.org.uk
