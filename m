Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263613AbSITWZN>; Fri, 20 Sep 2002 18:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263752AbSITWZN>; Fri, 20 Sep 2002 18:25:13 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:46307 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S263613AbSITWZN>; Fri, 20 Sep 2002 18:25:13 -0400
Date: Fri, 20 Sep 2002 15:30:19 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020920215029.GB1527@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0209201528360.22066-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Sep 2002, Bill Huey wrote:

> It's better to have an explict pthread_suspend_[thread,all]() function

could this be implemented by having a gc thread in a unique process group
and then suspending the jvm process group?

-dean

