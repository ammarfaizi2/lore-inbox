Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbTACUXr>; Fri, 3 Jan 2003 15:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTACUXq>; Fri, 3 Jan 2003 15:23:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:35325 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267646AbTACUWV>;
	Fri, 3 Jan 2003 15:22:21 -0500
Message-ID: <3E15F2F5.356A933D@digeo.com>
Date: Fri, 03 Jan 2003 12:30:45 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Korty <joe.korty@ccur.com>, sct@redhat.com, adilger@clusterfs.com,
       rusty@rustcorp.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
References: <200301031656.QAA29658@rudolph.ccur.com> <3E15ED74.6EF0DC4A@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2003 20:30:45.0829 (UTC) FILETIME=[FE8A0750:01C2B366]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous episode of "travails of a geriatric kernel jock",
Andrew Morton wrote:
> 
>  Unpatched 2.4.20 does the same thing.
> 

No it doesn't.

Good news is that 2.4.20 plus recent ext3 fixes doesn't lock up
either.
