Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUBEP6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 10:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUBEP6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 10:58:14 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:53776 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265276AbUBEP5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 10:57:46 -0500
Message-ID: <40226935.2050205@techsource.com>
Date: Thu, 05 Feb 2004 11:03:01 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Mattias Wadenstein <maswan@acc.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: Performance issue with 2.6 md raid0
References: <Pine.A41.4.58.0402051304410.28218@lenin.acc.umu.se> <402263E7.6010903@cyberone.com.au>
In-Reply-To: <402263E7.6010903@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:
>
> 
> Can you try booting with elevator=deadline please?
> 

Is there a "what to do before you make a bug report" FAQ?  If not, we 
need one.



1. If I'm having performance issues, what sorts of tests should I run 
before reporting?

1.1. If it's an I/O performance problem, try entering 
"elevator=deadline" at the lilo boot prompt and see what difference it 
makes.


