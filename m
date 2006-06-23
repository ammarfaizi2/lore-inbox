Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751995AbWFWTus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbWFWTus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbWFWTus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:50:48 -0400
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:22532 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751995AbWFWTur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:50:47 -0400
Date: Fri, 23 Jun 2006 21:50:54 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix cpufreq_{conservative,ondemand} compilation
Message-Id: <20060623215054.b9918b5d.khali@linux-fr.org>
In-Reply-To: <EB12A50964762B4D8111D55B764A84541D47D3@scsmsx413.amr.corp.intel.com>
References: <EB12A50964762B4D8111D55B764A84541D47D3@scsmsx413.amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venki,

> Thanks for the patch. Yes, I had missed this warning as some other patch
> in my local tree was adding cpu.h to cpufreq_ondemand.c

Oh well, a similar patch was merged by Andrew Morton already.

-- 
Jean Delvare
