Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTEAI3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 04:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTEAI3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 04:29:03 -0400
Received: from [12.47.58.20] ([12.47.58.20]:30634 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261168AbTEAI3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 04:29:03 -0400
Date: Thu, 1 May 2003 01:42:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: arjanv@redhat.com
Cc: ricklind@us.ibm.com, solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org,
       frankeh@us.ibm.com
Subject: Re: must-fix list for 2.6.0
Message-Id: <20030501014212.03d304e9.akpm@digeo.com>
In-Reply-To: <1051778205.1406.0.camel@laptop.fenrus.com>
References: <20030430121105.454daee1.akpm@digeo.com>
	<200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
	<20030430162108.09dbd019.akpm@digeo.com>
	<1051778205.1406.0.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 08:41:20.0054 (UTC) FILETIME=[701AB560:01C30FBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> Nuking a kernel feature
> (basically making sched_yield() more posix compliant) for ONE
> broken-since-fixed app doesn't sound like a good plan to me.

You're promising there are no others?

