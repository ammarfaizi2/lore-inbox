Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTFDSNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbTFDSNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:13:49 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:51854 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263782AbTFDSNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:13:47 -0400
Subject: Re: iptables & 2.5 problem
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Shawn <core@enodev.com>
Cc: Harald Welte <laforge@netfilter.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1054750920.6370.10.camel@localhost>
References: <1054747598.12295.5.camel@localhost>
	 <20030604180726.GG29818@sunbeam.de.gnumonks.org>
	 <1054750920.6370.10.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054751234.692.75.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Jun 2003 20:27:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 20:22, Shawn wrote:
> This would be great, except for iptables does not build against
> linux-2.5.70-mm3 due to lack of IPT_PHYSDEV_OP_MATCH_IN and
> IPT_PHYSDEV_OP_MATCH_OUT.
> 
> For that matter, there is no IPT_PHYSDEV_OP_MATCH* at all in the kernel
> source.

Use development iptables for a development kernel.

See http://netfilter.org/downloads.html#cvs

-- 
/Martin
