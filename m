Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWAMO7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWAMO7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422706AbWAMO7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:59:14 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:30897 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1422707AbWAMO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:59:14 -0500
Message-ID: <43C7C03B.7000305@gentoo.org>
Date: Fri, 13 Jan 2006 14:59:07 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org, Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: why sk98lin driver is not up-to date ?
References: <Xns97496767C8536ericbelhommefreefr@80.91.229.5> <200601120339.17071.chase.venters@clientec.com> <43C63361.103@reub.net> <20060112181844.D8EF9BAE5@mx.dtiltas.lt>
In-Reply-To: <20060112181844.D8EF9BAE5@mx.dtiltas.lt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nerijus Baliunas wrote:
> Which one is better and what is a difference between them? Which one
> will support Marvell Technology Group Ltd. 88E8050 Gigabit Ethernet Controller
> (rev 17)? skge in 2.6.14 does not support it.

skge supports Yukon
sky2 supports Yukon-2

88E8050 is Yukon-2.

Daniel
