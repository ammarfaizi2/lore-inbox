Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSKYBV3>; Sun, 24 Nov 2002 20:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSKYBV3>; Sun, 24 Nov 2002 20:21:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:56732 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262312AbSKYBVX>;
	Sun, 24 Nov 2002 20:21:23 -0500
Message-ID: <3DE17CBE.9F0FEC62@digeo.com>
Date: Sun, 24 Nov 2002 17:28:30 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: opps in kswapd
References: <25282B06EFB8D31198BF00508B66D4FA03EA5B14@fmsmsx114.fm.intel.com> <200211241021.54957.tomlins@cam.org> <20021124153017.GC18063@holomorphy.com> <200211241327.10443.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2002 01:28:30.0808 (UTC) FILETIME=[F65F7D80:01C29421]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> 
> Here is another 2.5.49-mm1 oops.

Looks like half an oops to me.  Is the rest of the info
not available?  Access address?  Code dump?  Type of
exception?
