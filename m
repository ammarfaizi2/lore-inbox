Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbSJAUH2>; Tue, 1 Oct 2002 16:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbSJAUH2>; Tue, 1 Oct 2002 16:07:28 -0400
Received: from packet.digeo.com ([12.110.80.53]:37863 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262260AbSJAUH2>;
	Tue, 1 Oct 2002 16:07:28 -0400
Message-ID: <3D9A01D6.EE7042B@digeo.com>
Date: Tue, 01 Oct 2002 13:13:10 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arador <diegocg@teleline.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40-mm1 oops
References: <20021001212944.28ed9231.diegocg@teleline.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2002 20:12:46.0625 (UTC) FILETIME=[E8741110:01C26986]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arador wrote:
> 
> Hi, this oops happens everytime i try to boot
> 2.5.39 on my box: - now in 2.5.40-mm1 too ;) -
> 

Please enable "Load all symbols for debugging/kksymoops"
under the "Kernel hacking" menu and send the backtrace.
