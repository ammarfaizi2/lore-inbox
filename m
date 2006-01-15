Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751616AbWAOB6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbWAOB6a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 20:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWAOB6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 20:58:30 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:56840 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751612AbWAOB6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 20:58:30 -0500
Date: Sat, 14 Jan 2006 20:57:59 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org,
       Nerijus Baliunas <nerijus@users.sourceforge.net>,
       Reuben Farrelly <reuben-lkml@reub.net>, dsd@gentoo.org
Subject: Re: why sk98lin driver is not up-to date ?
Message-ID: <20060115015756.GC32206@tuxdriver.com>
Mail-Followup-To: Harald Dunkel <harald.dunkel@t-online.de>,
	linux-kernel@vger.kernel.org,
	Nerijus Baliunas <nerijus@users.sourceforge.net>,
	Reuben Farrelly <reuben-lkml@reub.net>, dsd@gentoo.org
References: <Xns97496767C8536ericbelhommefreefr@80.91.229.5> <200601120339.17071.chase.venters@clientec.com> <43C63361.103@reub.net> <20060112181844.D8EF9BAE5@mx.dtiltas.lt> <43C7C03B.7000305@gentoo.org> <43C93760.7040502@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C93760.7040502@t-online.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 06:39:44PM +0100, Harald Dunkel wrote:
> Daniel Drake wrote:
> > Nerijus Baliunas wrote:
> > 
> >> Which one is better and what is a difference between them? Which one
> >> will support Marvell Technology Group Ltd. 88E8050 Gigabit Ethernet
> >> Controller
> >> (rev 17)? skge in 2.6.14 does not support it.
> > 
> > 
> > skge supports Yukon
> > sky2 supports Yukon-2
> > 
> > 88E8050 is Yukon-2.
> > 
> 
> Probably you need some testers for sky2. The -mm kernel would be a
> little bit too experimental for me, but it seems to be in -git10.
> Does this mean that it might appear in 2.6.15.1, or do I have to
> wait for 2.6.16?

If you happen to be a Fedora user, sky2 is available in the kernels here:

	http://people.redhat.com/linville/kernels/fedora-netdev/

Hth!

John
-- 
John W. Linville
linville@tuxdriver.com
