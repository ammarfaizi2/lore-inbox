Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSLZIJQ>; Thu, 26 Dec 2002 03:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSLZIJQ>; Thu, 26 Dec 2002 03:09:16 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:60582 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262528AbSLZIJP> convert rfc822-to-8bit; Thu, 26 Dec 2002 03:09:15 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [BENCHMARK] lmbench results for 5.53 mm1
Date: Thu, 26 Dec 2002 13:47:16 +0530
Message-ID: <94F20261551DC141B6B559DC491086720442A2@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] lmbench results for 5.53 mm1
Thread-Index: AcKssy/3e4qKydsUQteY8xY3EDS3ugAA92LQ
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>, "Larry McVoy" <lm@bitmover.com>
X-OriginalArrivalTime: 26 Dec 2002 08:17:17.0734 (UTC) FILETIME=[345DA460:01C2ACB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was not enabled.

> From: Andrew Morton [mailto:akpm@digeo.com] 
> Subject: Re: [BENCHMARK] lmbench results for 5.53 mm1
> 
> 
> Aniruddha M Marathe wrote:
> > 
> > 1. increase in time for fork proc       415             382
> > 2. increase in time for sh proc         8190            8088
> 
> pagetable sharing adds a little overhead to fork and exec in 
> microbenchmarks.  You should state whether it was enabled.
> 
