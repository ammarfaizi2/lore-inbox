Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267731AbTB1SBH>; Fri, 28 Feb 2003 13:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267906AbTB1SBH>; Fri, 28 Feb 2003 13:01:07 -0500
Received: from franka.aracnet.com ([216.99.193.44]:32717 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267731AbTB1SBH>; Fri, 28 Feb 2003 13:01:07 -0500
Date: Fri, 28 Feb 2003 10:11:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org, cliffw@osdl.org, akpm@zip.com.au,
       slpratt@austin.ibm.com, levon@movementarian.org, haveblue@us.ibm.com
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-ID: <28510000.1046455878@[10.10.2.4]>
In-Reply-To: <20030228093632.7bf053ed.rddunlap@osdl.org>
References: <8550000.1046419962@[10.10.2.4]> <20030228093632.7bf053ed.rddunlap@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These:          ^------------v  should be the same value (as you have it).
>                              v
>| +clear		echo 2 > /proc/profile
> man page says to use "readprofile -r".  Doesn't that still work?

Dunno. I always have done the above ... have you been using -r with
success? If so, I'll change it.

M.

