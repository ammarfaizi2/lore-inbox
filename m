Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTEAR6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTEAR6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:58:44 -0400
Received: from dyn-ctb-210-9-246-153.webone.com.au ([210.9.246.153]:54544 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261153AbTEAR6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:58:43 -0400
Message-ID: <3EB1632E.5000302@cyberone.com.au>
Date: Fri, 02 May 2003 04:10:54 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.68 and 2.5.68-mm2
References: <20030430005902.GA32599@rushmore>
In-Reply-To: <20030430005902.GA32599@rushmore>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:

>>A run with deadline on mm would be nice to see. 
>>
>
>Summary:
>Most benchmarks don't show much difference between 2.5.68-mm2 using
>anticipatory vs deadline scheduler.  AIM7 had almost no difference.  
>Tiobench has the most difference.
>
OK, thanks for that. I'd say it could be a TCQ or possibly
RAID or driver problem. I don't have anything in mind to
fix it yet but it has to be addressed at some point.

