Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUCBXrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUCBXrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:47:13 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:7613 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261793AbUCBXrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:47:07 -0500
Message-ID: <40451CE6.8020708@matchmail.com>
Date: Tue, 02 Mar 2004 15:46:46 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Darren Williams <dsw@gelato.unsw.edu.au>
CC: albhaf <albhaf@home.se>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Better performance with 2.6
References: <1078229894.53b994c0albhaf@home.se> <20040302221025.GA18011@cse.unsw.EDU.AU>
In-Reply-To: <20040302221025.GA18011@cse.unsw.EDU.AU>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Williams wrote:
> Hi albhaf
> 
> Look at the slab allocator, this is a cache
> for commonly used objects in the kernel.
> 
> For more info see the original document:
> The Slab Allocator:
> An object caching kernel memory allocator
> Jeff Bonwick

Slab is in the 2.4 kernel also...
