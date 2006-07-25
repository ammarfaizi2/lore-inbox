Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWGYXKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWGYXKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWGYXKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:10:16 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:46806 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1030244AbWGYXKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:10:14 -0400
Message-ID: <44C6A4CA.8040609@linuxtv.org>
Date: Tue, 25 Jul 2006 19:10:02 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Edgar Toernig <froese@gmx.de>
CC: mchehab@infradead.org, akpm@osdl.org, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org, alan@redhat.com, torvalds@osdl.org,
       linux-dvb-maintainer@linuxtv.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH 00/23] V4L/DVB fixes
References: <20060725180311.PS54604900000@infradead.org> <20060726004127.6eab5a9f.froese@gmx.de>
In-Reply-To: <20060726004127.6eab5a9f.froese@gmx.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig wrote:
> mchehab@infradead.org wrote:
>> It contains the following stuff:
>> [...]
> 
> I'm still missing the VBI_OFFSET fix.  See:
> 
>   http://marc.theaimsgroup.com/?m=114710558215044
> 
> Could you consider that patch for the next update and
> IMHO also for 2.6.16.x and 2.6.17.x?  

Please read Documentation/SubmittingPatches

Patches without a sign-off will not be included into the kernel.
