Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTEHQAa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTEHQA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:00:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:52685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261780AbTEHQA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:00:29 -0400
Message-Id: <200305081612.h48GCUW25789@mail.osdl.org>
Date: Thu, 8 May 2003 09:12:27 -0700 (PDT)
From: markw@osdl.org
Subject: Re: OSDL DBT-2 AS vs. Deadline 2.5.68-mm2
To: piggin@cyberone.com.au
cc: akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <3EB9B5BA.4080607@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 May, Nick Piggin wrote:
> markw@osdl.org wrote:
> 
>>I've collected some data from STP to see if it's useful or if there's
>>anything else that would be useful to collect. I've got some tests
>>queued up for the newer patches, but I wanted to put out what I had so
>>far.
>>
> Thanks. It looks like AS isn't doing too badly here. Newer mm kernels
> have some more AS changes, and the dynamic struct request patch which
> would be good to test.
> 
> Are you using TCQ on your disks?
> 

There's a queue depth being set.  Is that a good indicator that TCQ is
being used?  If not, I'd be happy to verify it.

Mark
