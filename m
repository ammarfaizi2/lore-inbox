Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbSJ2WMx>; Tue, 29 Oct 2002 17:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbSJ2WMx>; Tue, 29 Oct 2002 17:12:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:3756 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262397AbSJ2WMw>;
	Tue, 29 Oct 2002 17:12:52 -0500
Message-ID: <3DBF0958.F887DD69@digeo.com>
Date: Tue, 29 Oct 2002 14:19:04 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Reppert <arashi@arashi.yi.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: poll-related "scheduling while atomic", 2.5.44-mm6
References: <20021029153719.4ebc4486.arashi@arashi.yi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2002 22:19:04.0386 (UTC) FILETIME=[30B7A220:01C27F99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reppert wrote:
> 
> So my guess is somewhere between -mm5 and -mm6 we
> screwed up the atomicity count.

Mine too.  I'll check it out, thanks.

Do you have preemption enabled?
