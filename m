Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262195AbSJJTzu>; Thu, 10 Oct 2002 15:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262169AbSJJTyu>; Thu, 10 Oct 2002 15:54:50 -0400
Received: from va.cs.wm.edu ([128.239.2.31]:7443 "EHLO va.cs.wm.edu")
	by vger.kernel.org with ESMTP id <S262192AbSJJTuy>;
	Thu, 10 Oct 2002 15:50:54 -0400
Date: Thu, 10 Oct 2002 15:56:36 -0400
From: Bruce Lowekamp <lowekamp@CS.WM.EDU>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for pdc20265  FIXED BY 2.4.20-pre10-ac1
Message-ID: <7310000.1034279796@chorus.cs.wm.edu>
In-Reply-To: <23290000.1034110018@chorus.cs.wm.edu>
References: <21460000.1034108893@chorus.cs.wm.edu>
 <23290000.1034110018@chorus.cs.wm.edu>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> This patch is intended to fix the "pdc20265 secondary controller
> misidentified as primary" problem that occurs on motherboards including
> the 20265 as an onboard raid controller.  The patch is based on one
> suggested by Nick Orlov in August, but adds an additional printk to make
> the alternatives more palatable.

I was going to post revised patches, and go to a different mail client that 
didn't munge them so badly, but...

Since 2.4.20-pre10-ac1 merges the IDE from 2.5 into 2.4, it resolves this 
problem.

Bruce

