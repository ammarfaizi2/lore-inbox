Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSGZSiX>; Fri, 26 Jul 2002 14:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317956AbSGZSiX>; Fri, 26 Jul 2002 14:38:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61938 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317950AbSGZSiX>; Fri, 26 Jul 2002 14:38:23 -0400
Subject: Re: 2.4.19rc3-ac3 --> sched.c errors
From: Robert Love <rml@tech9.net>
To: Rohan Deshpande <rohan@myeastern.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020726182151.GA3392@myeastern.com>
References: <20020726182151.GA3392@myeastern.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 26 Jul 2002 11:41:37 -0700
Message-Id: <1027708897.2443.36.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 11:21, Rohan Deshpande wrote:
> Hello,
> 
> Upon compiling kernel 2.4.19rc3-ac3, I have been getting the following
> errors.  GCC is 2.95.4, on Debian Unstable.  Config is also attached.

Uh you all messed up... try redoing your tree completely.  Did the patch
fail to apply completely or something?

A correctly patched 2.4.19-rc3-ac3 compiles fine (it looks like your
sched.c and sched.h do not match).

	Robert Love


