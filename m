Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTD3TSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTD3TSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:18:12 -0400
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:18872 "EHLO
	bluesong.NET") by vger.kernel.org with ESMTP id S262369AbTD3TSL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:18:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@bluesong.net>
Reply-To: jfv@bluesong.net
To: "Wojciech Sobczak" <Wojciech.Sobczak@comarch.pl>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: IBM x440 problems on 2.4.20 to 2.4.20-rc1-ac3
Date: Wed, 30 Apr 2003 11:36:24 -0700
User-Agent: KMail/1.4.1
References: <01d601c30f17$f3ffadf0$b312840a@nbsobczak> <3270000.1051712524@[10.10.2.4]> <021501c30f27$e02be4a0$b312840a@nbsobczak>
In-Reply-To: <021501c30f27$e02be4a0$b312840a@nbsobczak>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304301136.24728.jfv@bluesong.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 April 2003 07:50 am, Wojciech Sobczak wrote:
> Martin J. Bligh wrote:
> > SuSE works well, at least the SLES edition does.
>
> but shoudn't it be platform independent? this is only kernel or meaby i
> need new gcc... or meaby something else?....

I has nothing to do with gcc, Alan mentioned the magic (or cursed is
probably the better choice :) word, ACPI. The kernel in SLES 8 has
the x440 blacklisted so ACPI gets turned off automagically :)

As John mentioned, you can use a generic kernel provided its 
recent enough AND you configure it properly for the box.

Cheers,

-- 
Jack F. Vogel		IBM Linux Technology Center
jfv@us.ibm.com (work)  ||  jfv@bluesong.net (home)
