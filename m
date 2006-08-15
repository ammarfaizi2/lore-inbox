Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWHOTxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWHOTxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWHOTxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:53:39 -0400
Received: from mail.everytruckjob.com ([198.87.235.158]:47584 "EHLO
	mail.everytruckjob.com") by vger.kernel.org with ESMTP
	id S932401AbWHOTxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:53:38 -0400
Message-ID: <44E2263D.4010909@everytruckjob.com>
Date: Tue, 15 Aug 2006 14:53:33 -0500
From: Mark Reidenbach <m.reidenbach@everytruckjob.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling
 enabled
References: <44E1F0CD.7000003@everytruckjob.com> <20060815180634.GB15957@s2.yuriev.com> <20060815181938.GK8776@1wt.eu>
In-Reply-To: <20060815181938.GK8776@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> He may very well have an IOS based 1600 or equivalent doing a very dirty NAT.
>
> Willy
>
>   
Willy, I am in fact running an IOS based NAT/firewall on a 1811.   It's 
IOS version 12.3(8)YI1.  Do you know if this version has a "very dirty 
NAT" implementation?   If you don't, I think I'll just try a few spare 
home routers and see if their NAT implementation is cleaner than my Cisco's.

Mark Reidenbach
EveryTruckJob.com
M.Reidenbach@EveryTruckJob.com
Phone: (205)722-9112
