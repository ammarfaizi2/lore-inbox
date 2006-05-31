Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWEaSHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWEaSHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWEaSHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:07:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:3728 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751762AbWEaSHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:07:19 -0400
X-Authenticated: #14349625
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
From: Mike Galbraith <efault@gmx.de>
To: balbir@in.ibm.com
Cc: Kirill Korotaev <dev@sw.ru>, Peter Williams <pwil3058@bigpond.net.au>,
       Balbir Singh <bsingharora@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
In-Reply-To: <447DBD44.5040602@in.ibm.com>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>
	 <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>
	 <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>
	 <447DBD44.5040602@in.ibm.com>
Content-Type: text/plain
Date: Wed, 31 May 2006 20:09:41 +0200
Message-Id: <1149098981.7555.30.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 21:29 +0530, Balbir Singh wrote:

> Do you have any documented requirements for container resource management?

(??  where would that come from?)

Containers, I can imagine ~working (albeit I don't see why num_tasks
dilution problem shouldn't apply to num_containers... it's the same
thing, stale info)

