Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUFWP5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUFWP5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265790AbUFWP5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:57:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:59544 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265517AbUFWP47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:56:59 -0400
Subject: Re: slow down with patch-2.6.7-mjb1
From: Darren Hart <dvhltc@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Phy Prabab <phyprabab@yahoo.com>
In-Reply-To: <20040622222217.11026.qmail@web51804.mail.yahoo.com>
References: <20040622222217.11026.qmail@web51804.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1088006252.6299.42.camel@farah>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Jun 2004 08:57:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 15:22, Phy Prabab wrote:
> Hello,
> 
> To mbligh, maintainer of mjb patch sets, et all:
> 
> I am trying to track down why I am seeing 2x in run
> time with patch-2.6.7-mjb1.  I would like to get the
> 4g/4g patch, hence the use of this patch set, however,
> something within this patch has more than doubled the
> run time for a test executable I have so I would like
> to see what component might be the cause.  Is there a
> list of the various patches that went into this patch
> set and if so, are the patches in a broken out format?

http://www.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.7/2.6.7-mjb1/

> 
> Thanks!
> Phy

Welcome

> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Darren Hart
IBM, Linux Technology Center
503 578 3185
dvhltc@us.ibm.com

