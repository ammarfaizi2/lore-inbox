Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312680AbSCVF60>; Fri, 22 Mar 2002 00:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312684AbSCVF6Q>; Fri, 22 Mar 2002 00:58:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:31360 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312680AbSCVF6C>; Fri, 22 Mar 2002 00:58:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 21 Mar 2002 22:02:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: David Schwartz <davids@webmaster.com>
cc: joeja@mindspring.com,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: max number of threads on a system
In-Reply-To: <20020322054916.AAA14361@shell.webmaster.com@whenever>
Message-ID: <Pine.LNX.4.44.0203212202060.1580-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, David Schwartz wrote:

>
>
> On Thu, 21 Mar 2002 20:05:39 -0500, joeja@mindspring.com wrote:
> >What limits the number of threads one can have on a Linux system?
>
> 	Common sense, one would hope.
>
> >I have a simple program that creates an array of threads and it locks up at
> >the creation of somewhere between 250 and 275 threads.

$ ulimit -u



- Davide


