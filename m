Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268098AbTB1TZH>; Fri, 28 Feb 2003 14:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268099AbTB1TZH>; Fri, 28 Feb 2003 14:25:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:6353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268098AbTB1TZH>;
	Fri, 28 Feb 2003 14:25:07 -0500
Date: Fri, 28 Feb 2003 11:30:41 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       levon@movementarian.org
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-Id: <20030228113041.0d0dd772.rddunlap@osdl.org>
In-Reply-To: <3E5FA6DF.8070909@us.ibm.com>
References: <8550000.1046419962@[10.10.2.4]>
	<20030228093632.7bf053ed.rddunlap@osdl.org>
	<28510000.1046455878@[10.10.2.4]>
	<3E5FA6DF.8070909@us.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003 10:13:51 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:

| Martin J. Bligh wrote:
| >>These:          ^------------v  should be the same value (as you have it).
| >>                             v
| >>| +clear		echo 2 > /proc/profile
| >>man page says to use "readprofile -r".  Doesn't that still work?
| > 
| > Dunno. I always have done the above ... have you been using -r with
| > success? If so, I'll change it.
| 
| It's what I've always used.

Same here (-r).

--
~Randy
