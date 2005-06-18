Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVFRWdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVFRWdR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 18:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVFRWdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 18:33:17 -0400
Received: from bay104-f33.bay104.hotmail.com ([65.54.175.43]:25701 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262179AbVFRWdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 18:33:12 -0400
Message-ID: <BAY104-F33EC080F521153F56952B884F70@phx.gbl>
X-Originating-IP: [65.54.175.204]
X-Originating-Email: [idht4n@hotmail.com]
In-Reply-To: <1119133125.4560.43.camel@mindpipe>
From: "David L" <idht4n@hotmail.com>
To: rlrevell@joe-job.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: bad: scheduling while atomic!: how bad?
Date: Sat, 18 Jun 2005 15:33:11 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Jun 2005 22:33:11.0617 (UTC) FILETIME=[B5821310:01C57455]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
>On Sat, 2005-06-18 at 14:59 -0700, David L wrote:
> > I'm seeing the message:
> >
> > bad: scheduling while atomic!
>
>It indicates a kernel bug, which could range from harmless to very bad.
>
>Usually that message is accompanied by a stack trace, can you provide a
>real log excerpt?
Is this what you need?

bad: scheduling while atomic!
[<c02a930f>]
[<c01f8c47>]
[<c01e6aea>]
[<c0120211>]
[<c01e6b30>]
[<c010f9a0>]
[<c02a8ff9>]
[<c010f9a0>]
[<c0120040>]
[<c0123983>]
[<c0123900>]
[<c0103b25>]

(or do you need config.gz and/or something else to make sense of it?)

Cheers...

           David

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

