Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWEHWjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWEHWjg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWEHWjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:39:35 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47824 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750827AbWEHWjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:39:35 -0400
Subject: Re: High load average on disk I/O on 2.6.17-rc3
From: Lee Revell <rlrevell@joe-job.com>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1FdE9I-00058a-00@calista.inka.de>
References: <E1FdE9I-00058a-00@calista.inka.de>
Content-Type: text/plain
Date: Mon, 08 May 2006 18:39:31 -0400
Message-Id: <1147127972.9116.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 00:24 +0200, Bernd Eckenfels wrote:
> Erik Mouw <erik@harddisk-recovery.com> wrote:
> > ... except that any kernel < 2.6 didn't account tasks waiting for disk
> > IO. Load average has always been somewhat related to tasks contending
> > for CPU power.
> 
> Actually all Linux kernels accounted for diskwaits and others like BSD based
> not. It is a very old linux oddness.

Maybe I am misunderstanding, but IIRC BSD/OS also counted processes
waiting on IO towards the load average.

Lee

