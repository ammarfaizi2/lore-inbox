Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291880AbSBHWVs>; Fri, 8 Feb 2002 17:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291884AbSBHWVi>; Fri, 8 Feb 2002 17:21:38 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:34522 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S291880AbSBHWVc>;
	Fri, 8 Feb 2002 17:21:32 -0500
Message-Id: <m16ZJNl-000OVeC@amadeus.home.nl>
Date: Fri, 8 Feb 2002 22:20:37 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: carson@antd.nist.gov (Mark E. Carson)
Subject: Re: What "module license" applies to public domain code?
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0202081632041.16834-100000@ran.antd.nist.gov>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0202081632041.16834-100000@ran.antd.nist.gov> you wrote:

> Of course, anyone else would be free to take the code and apply any
> license whatsoever to it, but my concern is simply what MODULE_LICENSE()
> line I can legitimately include, if any.

how about

MODULE_LICENSE("Dual GPL/Public Domain");

this would need adding to the proper headers though
