Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUD1PkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUD1PkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 11:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264834AbUD1PkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 11:40:06 -0400
Received: from mail5.atl.registeredsite.com ([64.224.219.79]:6068 "EHLO
	mail5.atl.registeredsite.com") by vger.kernel.org with ESMTP
	id S264833AbUD1PkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 11:40:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6-rc3
Newsgroups: linux.kernel
In-Reply-To: <1PMQ9-5K6-3@gated-at.bofh.it>
Organization: 
Message-Id: <20040428144801.B3708149A6@x23.networkingunlimited.com>
Date: Wed, 28 Apr 2004 10:48:01 -0400 (EDT)
From: vcjones@NetworkingUnlimited.com (Vincent C Jones)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1PMQ9-5K6-3@gated-at.bofh.it> you write:
>
>s390, cifs, ntfs, ppc, ppc64, cpufreq upates. Oh, and DVB and USB.
>
>I'm hoping to do a final 2.6.6 later this week, so I'm hoping as many 
>people as possible will test this.
>
>	Thanks,
>
>		Linus

loop-AES 2.0g has refused to compile since 2.6.6-rc1. No problems up
through 2.6.5. The make script cd's to the kernel source root, then
can't find any of the kernel include files, and it's all downhill from
there...

SuSE 9.0 on a ThinkPad X23. I'd be glad to provide more info if it would
help.

Vince
-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
14 Dogwood Lane, Tenafly, NJ 07670
http://www.networkingunlimited.com
VCJones@NetworkingUnlimited.com  +1 201 568-7810  Fax: +1 201 568-7269 
