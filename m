Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTHaPZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTHaPZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:25:09 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:60814 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262032AbTHaPZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:25:05 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, jes@trained-monkey.org,
       zaitcev@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl> <m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org> <m3n0dz5kfg.fsf@defiant.pm.waw.pl>
	<20030824060057.7b4c0190.davem@redhat.com>
	<m365kmltdy.fsf@defiant.pm.waw.pl> <m365kex2rp.fsf@defiant.pm.waw.pl>
	<20030830185007.5c61af71.davem@redhat.com>
	<1062334374.31861.32.camel@dhcp23.swansea.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 31 Aug 2003 17:24:29 +0200
In-Reply-To: <1062334374.31861.32.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <m38yp97suq.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Then I suggest we remove the feature until 2.7 since nobody has time
> to make it work in 2.6

I could possibly fix it with some help from platforms maintainters
(testing) but I'm not going to waste time knowing for sure that it
will be rejected, and probably doing it the wrong way.
-- 
Krzysztof Halasa, B*FH
