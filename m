Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUBWRwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 12:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbUBWRwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 12:52:13 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:44046 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S261976AbUBWRwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 12:52:12 -0500
Message-ID: <NkcvILAg5jOAFwZp@n-cantrell.demon.co.uk>
Date: Mon, 23 Feb 2004 17:54:40 +0000
To: linux-kernel@vger.kernel.org
From: robert of northworthige <bobh@n-cantrell.demon.co.uk>
Subject: Re: Is LOADLIN still viable for 2.6?
References: <20040223145740.M2949@www.igotu.com>
 <20040223081138.50f03334.rddunlap@osdl.org>
In-Reply-To: <20040223081138.50f03334.rddunlap@osdl.org>
MIME-Version: 1.0
X-Mailer: Turnpike Integrated Version 5.01 S <sUd$$IGoML1uLgd5isJZTxuCeM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040223081138.50f03334.rddunlap@osdl.org>, Randy.Dunlap
<rddunlap@osdl.org> writes
>On Mon, 23 Feb 2004 10:05:58 -0500 "Martin Bogomolni" <martinb@www.igotu.com> 
>wrote:
>
>| 
> 
>| Since it doesn't seem that Hans Lermen has been updating or maintaining
>| loadlin since the release of 2.4 is there anyone who is continuing to 
>maintain
>| LOADLIN, or has it fallen by the wayside?   Due to the nature of the system,
>| and a requirement for backwards compatibility and user interaction during
>| startup, I cannot use Peter Anvin's SYSLINUX linux loader which occurs too
>| early on in the process.
>| 
>| Are there any other options to startup a linux environment from DOS?
>
>I don't know anything about it, but you might look at gujin:
>  http://sourceforge.net/projects/gujin/
>
>--
>~Randy
>-

Hans produced loadlin1.6c for Pat Volkerding, about slack 8.1 time
(kernel 2.4.18). I'm sure he'd rise to the challenge to update for 2.6
if needed. 
And...
I've just tried loadlin1.6c on a 2.6.2 kernel and it's come up fine

Bob Hall

There's also linld (??) from a russian guy IIRC.


