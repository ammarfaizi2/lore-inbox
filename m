Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTGKPwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTGKPvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:51:36 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:61396
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264085AbTGKPuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:50:06 -0400
Date: Fri, 11 Jul 2003 12:04:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Flameeyes <daps_mls@libero.it>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711160448.GE2210@gtf.org>
References: <20030711140219.GB16433@suse.de> <1057939179.954.2.camel@laurelin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057939179.954.2.camel@laurelin>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 05:59:39PM +0200, Flameeyes wrote:
> On Fri, 2003-07-11 at 16:02, Dave Jones wrote:
> > - (Possibly linked to above bug) VIA APIC routing is currently broken.
> >   boot with 'noapic'.
> On my system (with VIA KT266 chipset) I can't boot also using noapic
> parameter, it freezes on "calibrating apic timer" using or not the
> noapic parameter.
> The only way is not enabling APIC at all.

More details, please.

Does 2.4.22-pre4 work for you?

	Jeff



