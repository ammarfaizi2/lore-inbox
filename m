Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273392AbSISVo3>; Thu, 19 Sep 2002 17:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273395AbSISVo3>; Thu, 19 Sep 2002 17:44:29 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:43143 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S273392AbSISVo2>;
	Thu, 19 Sep 2002 17:44:28 -0400
Message-ID: <3D8A464B.20209@us.ibm.com>
Date: Thu, 19 Sep 2002 14:48:59 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bond, Andrew" <Andrew.Bond@hp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TPC-C benchmark used standard RH kernel
References: <45B36A38D959B44CB032DA427A6E106402D09E45@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bond, Andrew wrote:
 > Don't have any data yet on 8-ways.  Our focus for the cluster was
 > 4-ways because those are what HP uses for most Oracle RAC
 > configurations.  We had done some testing last year that showed
 > very bad scaling from 4 to 8 cpus (only around 10% gain), but that
 > was in the days of 2.4.5.  The kernel has come a long way from
 > then, but like you said there is more work to do in the 8-way
 > arena.
 >
 > Are the 8-way's you are talking about 8 full processors, or 4 with
 > Hyperthreading?

The machines that I was talking about are normal 8 full processors. 
   They're only PIII's, so we don't even have the option.

-- 
Dave Hansen
haveblue@us.ibm.com

