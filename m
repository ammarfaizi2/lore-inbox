Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314406AbSDRS0K>; Thu, 18 Apr 2002 14:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314405AbSDRS0J>; Thu, 18 Apr 2002 14:26:09 -0400
Received: from holomorphy.com ([66.224.33.161]:18590 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314408AbSDRSZm>;
	Thu, 18 Apr 2002 14:25:42 -0400
Date: Thu, 18 Apr 2002 11:24:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables
Message-ID: <20020418182444.GV21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1589.1019123186@ocs3.intra.ocs.com.au> <1589.1019123186@ocs3.intra.ocs.com.au> <20020418135931.GU21206@holomorphy.com> <8N7App8mw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli@holomorphy.com (William Lee Irwin III)  wrote on 18.04.02 in <20020418135931.GU21206@holomorphy.com>:
>> It doesn't have to be an O(n lg(n)) method but could you use something
>> besides bubblesort? Insertion sort, selection sort, etc. are just as
>> easy and they don't have the horrific stigma of being "the worst sorting
>> algorithm ever" etc.

On Thu, Apr 18, 2002 at 08:16:00PM +0200, Kai Henningsen wrote:
> Surely the worst (working) sort is randomsort? (Check if sorted. If not,  
> pick two entries at random, exchange, retry.)

Perhaps I should have qualified it with "plausible" or something. The
intent is clear regardless.

Cheers,
Bill
