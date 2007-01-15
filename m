Return-Path: <linux-kernel-owner+w=401wt.eu-S1750790AbXAOP0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbXAOP0d (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 10:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbXAOP0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 10:26:33 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:20672 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750790AbXAOP0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 10:26:32 -0500
Message-ID: <45AB9D22.9000702@cfl.rr.com>
Date: Mon, 15 Jan 2007 10:26:26 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Alberto Alonso <alberto@ggsys.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Ext3 mounted as ext2 but journal still in effect.
References: <1168578496.9707.6.camel@w100> <20070111212545.efd5d8c5.akpm@osdl.org> <1168585021.9707.25.camel@w100> <20070112144103.GA7685@ucw.cz>
In-Reply-To: <20070112144103.GA7685@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2007 15:26:44.0097 (UTC) FILETIME=[90185F10:01C738B9]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14936.003
X-TM-AS-Result: No--1.921500-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not just use tune2fs to remove the ext3 journal?

