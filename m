Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbTFLRRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbTFLRRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:17:55 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:15086 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S264918AbTFLRRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:17:50 -0400
From: Artemio <artemio@artemio.net>
To: Matt Reppert <repp0017@tc.umn.edu>
Subject: Re: SMP question
Date: Thu, 12 Jun 2003 20:25:10 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKMEJLDJAA.davids@webmaster.com> <200306120837.40421.artemio@artemio.net> <20030612084932.437a010c.repp0017@tc.umn.edu>
In-Reply-To: <20030612084932.437a010c.repp0017@tc.umn.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306122025.10583.artemio@artemio.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As I understood, with HT enabled, Linux-SMP sees four CPUs with 5000 bogo
> > mips each (of course I've already seen this in /proc/cpuinfo).
> >
> > So, if I deactivate HT, will a UP Linux see one CPU with 4x5000=20000
> > bogo mips?
>
> No. It will see one CPU with 5000 BogoMips.

Thanks, I've already checked this out myself.

We have decided not to use rtlinux on SMP - it seems to be some bug in rtlinux 
- but that's not for discussion here.

Thank you all for your replies.

Good luck!

Artemio.

