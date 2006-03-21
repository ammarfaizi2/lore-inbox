Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWCWQV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWCWQV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbWCWQV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:21:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25096 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161004AbWCWQVO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:21:14 -0500
Date: Tue, 21 Mar 2006 19:33:08 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][1/2] sched: sched.c task_t cleanup
Message-ID: <20060321193308.GA2370@ucw.cz>
References: <200603180004.13967.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603180004.13967.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 18-03-06 00:04:13, Con Kolivas wrote:
> Replace all task_struct instances in sched.c with task_t
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>

task_struct looks nicer to my eyes, is consistent with CodingStyle,
and everyone is already familiar with it.

								Pavel

-- 
Thanks, Sharp!
