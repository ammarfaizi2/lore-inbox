Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUCFO6G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 09:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUCFO6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 09:58:06 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:23487 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261678AbUCFO6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 09:58:03 -0500
Message-ID: <4049E6BE.6080905@stesmi.com>
Date: Sat, 06 Mar 2004 15:57:02 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Ryan Earl" <heretic@clanhk.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 3Com 3C2000-T support in 2.6?
References: <4049AE4F.7080605@clanhk.org>
In-Reply-To: <4049AE4F.7080605@clanhk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> I was wondering, has anyone gotten the 3C2000-T gigE card up under 2.6?  
> It apparently comes with driver source for the 2.4 kernel on its CD.  
> Nice specs: 
> http://www.3com.com/products/en_US/detail.jsp?tab=features&sku=3C2000-T&pathtype=support 
> 
> 
> Nice sized buffers and IP offload in a cheap package.

I don't know about 2.6 but in 2.4, use the sk98lin driver.

The 3C2000 is the same as the 3C940 and it works here.

// Stefan
