Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbTIOHos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 03:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbTIOHos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 03:44:48 -0400
Received: from law11-f36.law11.hotmail.com ([64.4.17.36]:16146 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261219AbTIOHop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 03:44:45 -0400
X-Originating-IP: [220.224.1.162]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: mpm@selenic.com
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: [CRYPTO] Testing Module Cleanup.
Date: Mon, 15 Sep 2003 13:14:44 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F36tRc0JFaTij0002c9ae@hotmail.com>
X-OriginalArrivalTime: 15 Sep 2003 07:44:44.0981 (UTC) FILETIME=[3B136E50:01C37B5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch is too long.
that's why i'm not including it in mail body.
if it's empty, any way i'm resending it.
thanks for comment.
                   -Kartikey Mahendra Bhatt


>From: Matt Mackall <mpm@selenic.com>
>To: kartikey bhatt <kartik_me@hotmail.com>
>CC: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
>Subject: Re: [CRYPTO] Testing Module Cleanup.
>Date: Sun, 14 Sep 2003 22:16:43 -0500
>
>On Mon, Sep 15, 2003 at 12:30:10AM +0530, kartikey bhatt wrote:
> > Hi James.
> >
> > I have cleaned up the testing module.
> > A complete rewrite.
> > Code is reduced by almost 1900+ lines in tcrypt.c.
> > I have compiled and test it on my machine.
> > The kernel size is reduced by 5 Kb.
> > I am including the patch for testing as an attachment.
> > It provides uniform interface for adding new tests.
> > Anyway, I think, now you won't call it a dirty module.
> > I expect changes in the comments at the beginning of source files.
> > Any suggestions are welcome.
> >
> >                    -Kartikey Mahendra Bhatt
>
>It's generally preferred to post patches in the body of your messages
>rather than as an attachment. The attachment you posted also appears
>to be empty.
>
>--
>Matt Mackall : http://www.selenic.com : of or relating to the moon

_________________________________________________________________
Talk to Karthikeyan. Watch his stunning feats. 
http://server1.msn.co.in/sp03/tataracing/index.asp Download images.

