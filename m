Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUFHFsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUFHFsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 01:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUFHFsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 01:48:52 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:63936 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264819AbUFHFsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 01:48:51 -0400
Date: Tue, 8 Jun 2004 01:50:28 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
In-Reply-To: <20040608054200.66080.qmail@web51803.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0406080149190.1838@montezuma.fsmlabs.com>
References: <20040608054200.66080.qmail@web51803.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yOn Mon, 7 Jun 2004, Phy Prabab wrote:

> The test case is a build system that links headers (ln
> -s) and runs bison and flex on a couple of files.
> strace shows no difference between running on 2.4.23
> compared to running on 2.6.7-rc2bk8s63.
>
> Unfortuneately, I can not send this out, but I am
> trying to get a tet case that will demostrate this.
>
> In the mean time, what can I do to try understand this
> slowdown?

Whether the regression is also present without the staircase scheduler.
