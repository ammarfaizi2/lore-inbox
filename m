Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTIAICL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 04:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTIAICK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 04:02:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48785 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262736AbTIAICH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 04:02:07 -0400
Date: Mon, 1 Sep 2003 00:52:59 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: khc@pm.waw.pl, jes@trained-monkey.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
Message-Id: <20030901005259.73f77f24.davem@redhat.com>
In-Reply-To: <1062402857.13087.4.camel@dhcp23.swansea.linux.org.uk>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl>
	<m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org>
	<m3n0dz5kfg.fsf@defiant.pm.waw.pl>
	<20030824060057.7b4c0190.davem@redhat.com>
	<m365kmltdy.fsf@defiant.pm.waw.pl>
	<m365kex2rp.fsf@defiant.pm.waw.pl>
	<20030830185007.5c61af71.davem@redhat.com>
	<1062334374.31861.32.camel@dhcp23.swansea.linux.org.uk>
	<20030831222233.1bd41f01.davem@redhat.com>
	<1062402857.13087.4.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Sep 2003 08:54:18 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Unfortunately those people don't have time to finish the feature for 2.6
> so its just going to cause bugs and accidents.

It does work for the case it was created for, it you want
to put a note into the documentation mentioning the current
limitations then fine.

But knowing breaking the tree for people is bad practice.
