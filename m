Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbTEHB3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 21:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbTEHB3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 21:29:15 -0400
Received: from dyn-ctb-203-221-73-28.webone.com.au ([203.221.73.28]:44292 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264391AbTEHB3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 21:29:14 -0400
Message-ID: <3EB9B5BA.4080607@cyberone.com.au>
Date: Thu, 08 May 2003 11:41:14 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: markw@osdl.org
CC: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: OSDL DBT-2 AS vs. Deadline 2.5.68-mm2
References: <200305071633.h47GXWW15850@mail.osdl.org>
In-Reply-To: <200305071633.h47GXWW15850@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org wrote:

>I've collected some data from STP to see if it's useful or if there's
>anything else that would be useful to collect. I've got some tests
>queued up for the newer patches, but I wanted to put out what I had so
>far.
>
Thanks. It looks like AS isn't doing too badly here. Newer mm kernels
have some more AS changes, and the dynamic struct request patch which
would be good to test.

Are you using TCQ on your disks?

