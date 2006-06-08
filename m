Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWFHBw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWFHBw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 21:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWFHBw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 21:52:28 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:12195
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932459AbWFHBw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 21:52:27 -0400
Message-ID: <448782D9.6060303@microgate.com>
Date: Wed, 07 Jun 2006 20:52:25 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
References: <1149694978.12920.14.camel@amdx2.microgate.com>	<20060607230202.GA12210@havoc.gtf.org>	<44876D59.1000509@microgate.com>	<44877659.2020103@microgate.com> <20060607182808.a230e5ee.akpm@osdl.org>
In-Reply-To: <20060607182808.a230e5ee.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Well your patch looked reasonable, except it muddies the CONFIG_foo
> namespace.  So could you rework it thusly:

OK

This at least looks like light at the end of
the tunnel, barring any further sniping.

I'll generate another patch along those lines.
If it's accepted, fine. If not, also fine.

--
Paul
