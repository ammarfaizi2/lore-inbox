Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268417AbTCFVuE>; Thu, 6 Mar 2003 16:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268422AbTCFVuE>; Thu, 6 Mar 2003 16:50:04 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:11501 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268417AbTCFVuB> convert rfc822-to-8bit; Thu, 6 Mar 2003 16:50:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Michael Hayes <mike@aiinc.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix breakage caused by spelling 'fix'
Date: Thu, 6 Mar 2003 22:59:20 +0100
User-Agent: KMail/1.4.3
Cc: torvalds@transmeta.com
References: <200303062141.h26LfZK19533@aiinc.aiinc.ca>
In-Reply-To: <200303062141.h26LfZK19533@aiinc.aiinc.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303062259.20480.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 March 2003 22:41, Michael Hayes wrote:

Hi Michael,

> This fixes a spelling "fix" that resulted in a compile error.
> With apologies to Russell King.
> diff -ur a/include/asm-arm/proc-fns.h b/include/asm-arm/proc-fns.h
> --- a/include/asm-arm/proc-fns.h	Tue Mar  4 19:29:20 2003
> +++ b/include/asm-arm/proc-fns.h	Thu Mar  6 11:46:15 2003
> @@ -125,7 +125,7 @@
>
>  #if 0
>   * The following is to fool mkdep into generating the correct
> - * dependencies.  Without this, it can't figure out that this
> + * dependencies.  Without this, it cant figure out that this
A spelling fix should be a right spelling fix ;)

So either "cannot" or "can not" but not "cant" :)

ciao, Marc
