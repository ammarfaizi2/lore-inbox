Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUBOEJk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 23:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUBOEJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 23:09:40 -0500
Received: from mxsf27.cluster1.charter.net ([209.225.28.227]:12040 "EHLO
	mxsf27.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S263946AbUBOEJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 23:09:35 -0500
Date: Sat, 14 Feb 2004 23:05:23 -0500 (EST)
From: ameer armaly <ameer@charter.net>
X-X-Sender: ameer@debian
To: Armen Kaleshian <akaleshian@kriation.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel boot order
In-Reply-To: <20040214065459.GA18235@sevoog.kriation.com>
Message-ID: <Pine.LNX.4.58.0402142304520.284@debian>
References: <Pine.LNX.4.58.0402132237320.14412@debian>
 <20040214065459.GA18235@sevoog.kriation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reffer to the various modules that are linked directly linked into the
kernel; that are set to y in make config.

On Sat, 14 Feb 2004, Armen Kaleshian wrote:

> What do you mean by what parts? The kernel enables your system devices, and then
> other services are started based on what you have specified to start at the run
> level you've set the machine to boot to.
>
> Please clarify your question so that I may better answer it.
>
> --Armen
>
> On Fri, Feb 13, 2004 at 10:39:11PM -0500, ameer armaly wrote:
> : Hi all.
> : What determines the order in which parts of the kernel are loaded?  Is it
> : in main.c or omsething like that or is it in the link order, or something
> : totally different.
> : Please reply privately to me at ameer@charter.net since I can't handle 300
> : msgs a day.
> : Thanks,
> :
> :
> :
> : Ameer
> :
> : -
> : To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> : the body of a message to majordomo@vger.kernel.org
> : More majordomo info at  http://vger.kernel.org/majordomo-info.html
> : Please read the FAQ at  http://www.tux.org/lkml/
>
