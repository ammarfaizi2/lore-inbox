Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbSJCV7Z>; Thu, 3 Oct 2002 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbSJCV7Z>; Thu, 3 Oct 2002 17:59:25 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:31731 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261341AbSJCV7Y>; Thu, 3 Oct 2002 17:59:24 -0400
Subject: Re: linux-2.4.20-pre8-ac3: NFS performance regression
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Pfaller <apfaller@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200210032024.47664.apfaller@yahoo.com.au>
References: <200210032024.47664.apfaller@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 23:13:04 +0100
Message-Id: <1033683184.28814.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 19:32, Andreas Pfaller wrote:
> However I noticed a significant NFS performance drop with
> 2.4.20-pre8-ac3. Other network throughput is not affected.

I see this with all recent 2.4.20pre and 2.4.20pre-ac kernels. I've not
had time to retest with Trond's fixes to recheck it all


