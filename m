Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbSLWUW4>; Mon, 23 Dec 2002 15:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbSLWUW4>; Mon, 23 Dec 2002 15:22:56 -0500
Received: from ns.netrox.net ([64.118.231.130]:27568 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S266968AbSLWUWz>;
	Mon, 23 Dec 2002 15:22:55 -0500
Subject: Re: [PROBLEM 2.5.52] PREEMPT broken (was "bad: scheduling while
	atomic!" errors during boot)
From: Robert Love <rml@tech9.net>
To: Simon Michael <simon@joyful.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87vg1kwnv2.fsf_-_@joyful.com>
References: <87znqxabgm.fsf@joyful.com> <87ptrt2lk3.fsf@joyful.com>
	 <87vg1kwnv2.fsf_-_@joyful.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040675593.962.6.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 23 Dec 2002 15:33:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-23 at 14:12, Simon Michael wrote:

> Yup, that's what I meant. Thanks to another private emailer for the idea.
> 
> Robert, I think you are the one who'll want to hear of this.

The problem is actually unrelated to preempt, but only with preempt can
we detect it.  So, yes, disabling CONFIG_PREEMPT merely hides the debug
message.

I got your post from earlier, thanks.  The relevant maintainers need to
work on it.

	Robert Love

