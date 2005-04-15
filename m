Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVDOBOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVDOBOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 21:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVDOBOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 21:14:12 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:57110 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261704AbVDOBOJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 21:14:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jMzEk8bsso2s7HNniC8BXWVRm1uZRq9WHpDE+GBoFuCT4V7AmVOBW2d5huO/xjN3eFpirfcUoW6jcqXuiUTa+djYeh/MdGzrQZJzwBBvVcCV867io9IETuzCF2WKI1UzXgjcN/V0xe0yIOWot7Cn85X928myJDfuX1QX1VkHaVU=
Message-ID: <c26b95920504141814722cb5ed@mail.gmail.com>
Date: Fri, 15 Apr 2005 06:44:06 +0530
From: Imanpreet Arora <imanpreet@gmail.com>
Reply-To: Imanpreet Arora <imanpreet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Question On TSS
In-Reply-To: <c26b959205041417163acf174@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c26b959205041417163acf174@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Never mind, I was missing something really simple.



On 4/15/05, Imanpreet Arora <imanpreet@gmail.com> wrote:
> Hello,
> 
> I am a bit confused about the TSS. The documentation says that it
> includes 3 fields SS0, SS1 and SS2 for privilige levels 0, 1, 2
> respectively. And are set up when a task is first created, I can't
> figure out why these fields are necessary. I think that these fileds
> are necessary when we have moved from PL 3 to PL0 and these would
> contain information about upper 3 stacks so that information can be
> retrived.

-- 

Imanpreet Singh Arora
