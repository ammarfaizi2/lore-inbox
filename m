Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUCIFtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 00:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUCIFtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 00:49:11 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:15840 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261253AbUCIFtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 00:49:09 -0500
Message-ID: <404D5A6F.4070300@matchmail.com>
Date: Mon, 08 Mar 2004 21:47:27 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 4/4] vm-mapped-x-active-lists
References: <404D56D8.2000008@cyberone.com.au> <404D5784.9080004@cyberone.com.au>
In-Reply-To: <404D5784.9080004@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> ------------------------------------------------------------------------
> 
> 
> Split the active list into mapped and unmapped pages.

This looks similar to Rik's Active and Active-anon lists in 2.4-rmap.

Also, how does this interact with Andrea's VM work?
