Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272164AbSISSK3>; Thu, 19 Sep 2002 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272182AbSISSK3>; Thu, 19 Sep 2002 14:10:29 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:61077 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S272164AbSISSK1>;
	Thu, 19 Sep 2002 14:10:27 -0400
Message-ID: <3D8A141D.2080809@us.ibm.com>
Date: Thu, 19 Sep 2002 11:14:53 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bond, Andrew" <Andrew.Bond@hp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TPC-C benchmark used standard RH kernel
References: <45B36A38D959B44CB032DA427A6E106402D09E42@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bond, Andrew wrote:
 > I believe I need to clarify my earlier posting about kernel features that
 > gave the benchmark a boost.  The kernel that we used in the benchmark was an
 > unmodified Red Hat Advanced Server 2.1 kernel.  We did tune the kernel via
 > standard user space tuning, but the kernel was not patched.  HP, Red Hat, and
 > Oracle have worked closely together to make sure that the features I
 > mentioned were in the Advanced Server kernel "out of the box."

Have you done much profiling of that kernel?  I'm sure a lot of people would be 
very interested to see even readprofile results from a piece of the cluster 
during a TPC run.

-- 
Dave Hansen
haveblue@us.ibm.com

