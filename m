Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261591AbSIXHHu>; Tue, 24 Sep 2002 03:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSIXHHt>; Tue, 24 Sep 2002 03:07:49 -0400
Received: from p50887F8B.dip.t-dialin.net ([80.136.127.139]:6871 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261591AbSIXHHl>; Tue, 24 Sep 2002 03:07:41 -0400
Date: Tue, 24 Sep 2002 01:12:05 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Ingo Molnar <mingo@elte.hu>
cc: Bill Davidsen <davidsen@tmr.com>, Larry McVoy <lm@bitmover.com>,
       Peter Waechtler <pwaechtler@mac.com>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <Pine.LNX.4.44.0209232218320.2118-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209240111330.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 23 Sep 2002, Ingo Molnar wrote:
> 90% of the programs that matter behave exactly like Larry has described.
> IO is the main source of blocking. Go and profile a busy webserver or
> mailserver or database server yourself if you dont believe it.

Well, I guess Java Web Server behaves the same?

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

