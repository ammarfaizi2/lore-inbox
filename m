Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbTB1SEa>; Fri, 28 Feb 2003 13:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267921AbTB1SEa>; Fri, 28 Feb 2003 13:04:30 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:49335 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267906AbTB1SE3>;
	Fri, 28 Feb 2003 13:04:29 -0500
Message-ID: <3E5FA6DF.8070909@us.ibm.com>
Date: Fri, 28 Feb 2003 10:13:51 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org, akpm@zip.com.au, slpratt@austin.ibm.com,
       levon@movementarian.org
Subject: Re: [PATCH] documentation for basic guide to profiling
References: <8550000.1046419962@[10.10.2.4]> <20030228093632.7bf053ed.rddunlap@osdl.org> <28510000.1046455878@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>These:          ^------------v  should be the same value (as you have it).
>>                             v
>>| +clear		echo 2 > /proc/profile
>>man page says to use "readprofile -r".  Doesn't that still work?
> 
> Dunno. I always have done the above ... have you been using -r with
> success? If so, I'll change it.

It's what I've always used.

-- 
Dave Hansen
haveblue@us.ibm.com

