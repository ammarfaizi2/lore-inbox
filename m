Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbUBYPw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUBYPwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:52:55 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:13839 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261374AbUBYPwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:52:54 -0500
Message-ID: <403CC72E.5000603@techsource.com>
Date: Wed, 25 Feb 2004 11:02:54 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Dmitry M Shatrov <erdizz@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: OpenGL in the kernel
References: <403D2953.7080909@mail.ru>
In-Reply-To: <403D2953.7080909@mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dmitry M Shatrov wrote:
> I think this is the right place to ask it for, sorry if not.
> I heard a few about future OpenGL implementation in the Linux kernel, 
> but failed to find any resource on this question. I also remember a 
> message from this list about its author's experiments with Mesa in this 
> key..
> Does anybody work on the subject now? Could you help me with (if there 
> are any) some links or just explain what's this really about?
> 
> With best regards, Dmitry M. Shatrov


It would certainly be productive to have certain system-level things in 
the kernel, such as support for interrupts and DMA, but we already have 
that in the form of DRI, and there is no other reason to put something 
like that into the kernel.  What advantage would there be that would 
outweigh all of the numerous disadvantages?


