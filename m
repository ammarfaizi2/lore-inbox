Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSGADwC>; Sun, 30 Jun 2002 23:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315424AbSGADwB>; Sun, 30 Jun 2002 23:52:01 -0400
Received: from roc-66-66-84-128.rochester.rr.com ([66.66.84.128]:51331 "EHLO
	death.krwtech.com") by vger.kernel.org with ESMTP
	id <S315423AbSGADwA>; Sun, 30 Jun 2002 23:52:00 -0400
Date: Sun, 30 Jun 2002 23:53:55 -0400 (EDT)
From: Ken Witherow <ken@krwtech.com>,
       <MISSING_MAILBOX_TERMINATOR@.SYNTAX-ERROR>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: Philip Wyett <philipwyett@dsl.pipex.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan 2460/Dual Athlon MP hangs
In-Reply-To: <200207010013.38955.philipwyett@dsl.pipex.com>
Message-ID: <Pine.LNX.4.44.0206302352320.340-100000@death>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Philip Wyett wrote:

> Hi,
>
> This issue has all the hallmarks of PSU problems. I had the same issue running
> dual Athlon MP's with a GeForce 4 Ti4600 until I switched the 400W PSU that
> came with the case too an Enermax 550W beast. The basic Tyan approved PSU for
> the 2460 is a M2463 (460W) unit when talking to my main vendor specifically
> because of all the problems with lockups and failures to even POST (Power On
> Self Test) etc.

I have seen it fail to properly post after rebooting and I figured it
might be the ACPI problem I've seen people have before. I'll upgrade the
PSU and see if that doesn't take care of the problem. Thanks to everyone
for the advice :)

-- 
 Ken Witherow <phantoml AT rochester.rr.com> ICQ: 21840670
         KRW Technologies http://www.krwtech.com
    Linux 2.4.18 - because I'd like to get there today
to remain free, we must remain free of intrusive government


