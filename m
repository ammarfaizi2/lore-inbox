Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWCWQVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWCWQVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422631AbWCWQV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:21:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26376 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161003AbWCWQVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:21:12 -0500
Date: Tue, 21 Mar 2006 19:34:17 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2/2] sched: sched.c runqueue_t cleanup
Message-ID: <20060321193417.GB2370@ucw.cz>
References: <200603180004.59946.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603180004.59946.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Replace all struct runqueue instances in sched.c with runqueue_t

Please don't. I'd assume runqueue_t is some kind of cookie.


								Pavel

-- 
Thanks, Sharp!
