Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUBYAFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbUBYACP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:02:15 -0500
Received: from mail.zmailer.org ([62.78.96.67]:54438 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262542AbUBYAAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:00:03 -0500
Date: Wed, 25 Feb 2004 01:59:56 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Dmitry M Shatrov <erdizz@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OpenGL in the kernel
Message-ID: <20040224235955.GO1751@mea-ext.zmailer.org>
References: <403D2953.7080909@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403D2953.7080909@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 02:01:39AM +0300, Dmitry M Shatrov wrote:
> I think this is the right place to ask it for, sorry if not.
> I heard a few about future OpenGL implementation in the Linux kernel, 
> but failed to find any resource on this question. I also remember a 
> message from this list about its author's experiments with Mesa in this 
> key..
> Does anybody work on the subject now? Could you help me with (if there 
> are any) some links or just explain what's this really about?

As a rule: KERNEL IS WRONG PLACE.

There are some primitive things that to an extent make sense, but
WHOLE OpenGL (which alone is nothing) or any other graphics server 
entirely in kernel ?   No way.

The XFree86 server can use kernel supplied DRI (Direct Rendering 
Interface) facilities, if such are available.

You can find more about this recurring topic in list archives.

> With best regards, Dmitry M. Shatrov

/Matti Aarnio
