Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVBLWIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVBLWIp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 17:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVBLWIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 17:08:45 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:61898 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261214AbVBLWHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 17:07:55 -0500
Message-ID: <420E7E30.5020605@us.ibm.com>
Date: Sat, 12 Feb 2005 14:07:44 -0800
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper: multipath hardware handler for EMC
References: <20050211172211.GA10195@agk.surrey.redhat.com> <20050211195841.GA13925@infradead.org>
In-Reply-To: <20050211195841.GA13925@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>>+/* Code borrowed from dm-lsi-rdac by Mike Christie */
> 
> 
> Any reason that module isn't submitted?
> 

I do not have access to their HW specs, and have been busy with
some iscsi things so I did not have time to finish things up.

I was also hoping LSI would soon figure out that they should be
using dm (I have seen some of them pop up now and then only)
and take over the work.

