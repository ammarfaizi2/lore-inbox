Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTFDSSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbTFDSSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:18:24 -0400
Received: from CPE-24-163-209-144.mn.rr.com ([24.163.209.144]:60033 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S263800AbTFDSSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:18:23 -0400
Subject: Re: iptables & 2.5 problem
From: Shawn <core@enodev.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Harald Welte <laforge@netfilter.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1054751234.692.75.camel@tux.rsn.bth.se>
References: <1054747598.12295.5.camel@localhost>
	 <20030604180726.GG29818@sunbeam.de.gnumonks.org>
	 <1054750920.6370.10.camel@localhost>
	 <1054751234.692.75.camel@tux.rsn.bth.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1054751512.6371.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 04 Jun 2003 13:31:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Awesome, thanks.

On Wed, 2003-06-04 at 13:27, Martin Josefsson wrote:
> On Wed, 2003-06-04 at 20:22, Shawn wrote:
> > This would be great, except for iptables does not build against
> > linux-2.5.70-mm3 due to lack of IPT_PHYSDEV_OP_MATCH_IN and
> > IPT_PHYSDEV_OP_MATCH_OUT.
> > 
> > For that matter, there is no IPT_PHYSDEV_OP_MATCH* at all in the kernel
> > source.
> 
> Use development iptables for a development kernel.
> 
> See http://netfilter.org/downloads.html#cvs
