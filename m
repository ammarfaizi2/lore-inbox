Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWBMPrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWBMPrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWBMPrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:47:06 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:44305 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750735AbWBMPrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:47:05 -0500
Message-ID: <43F0A9B7.5090007@cfl.rr.com>
Date: Mon, 13 Feb 2006 10:45:59 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org,
       Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Packet writing issue on 2.6.15.1
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com> <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com> <20060211170813.3fb47a03@silver> <43EE446C.8010402@cfl.rr.com> <20060211211440.3b9a4bf9@silver> <43EE8B20.7000602@cfl.rr.com> <2006021 <20060213044029.GF7450@squish.home.loc>
In-Reply-To: <20060213044029.GF7450@squish.home.loc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 15:48:48.0238 (UTC) FILETIME=[FA8C40E0:01C630B4]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14265.000
X-TM-AS-Result: No-0.632000-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> 	Hi;
>
> 	Ah, I havent used a cd-rw in quite some time; I recall now
> that I had to do an initial format on the dvd-rw with dvd+rw-format,
> but had never used cdrwtool in the process. Thanks for the correction.

dvd+rw-format formats discs in MRW mode, so you don't need pktcdvd to 
access them.  MRW mode is less compatible than packet mode, and may 
yield less usable space due to the sector sparing. 


