Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbSLWTMW>; Mon, 23 Dec 2002 14:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbSLWTMW>; Mon, 23 Dec 2002 14:12:22 -0500
Received: from main.gmane.org ([80.91.224.249]:16334 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S266941AbSLWTMV>;
	Mon, 23 Dec 2002 14:12:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Simon Michael <simon@joyful.com>
Subject: Re: [PROBLEM 2.5.52] PREEMPT broken (was "bad: scheduling while
 atomic!" errors during boot)
Date: Mon, 23 Dec 2002 11:12:49 -0800
Organization: Joyful Systems
Message-ID: <87vg1kwnv2.fsf_-_@joyful.com>
References: <87znqxabgm.fsf@joyful.com> <87ptrt2lk3.fsf@joyful.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
Cc: rml@tech9.net (Robert Love)
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Simon Michael <simon@joyful.com> writes:
>> Turning off CONFIG_PREEMPT fixes this problem.
>
> Change fixes to hides and you are correct.  Reporting
> these error is a real good idea.

Yup, that's what I meant. Thanks to another private emailer for the idea.

Robert, I think you are the one who'll want to hear of this.

Best regards,
-Simon 




