Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWEHKBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWEHKBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 06:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWEHKBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 06:01:16 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:30636 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750892AbWEHKBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 06:01:16 -0400
Date: Mon, 8 May 2006 06:01:13 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Krishna Chaitanya <lnxctnya@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: real-time in linux
In-Reply-To: <ae649ba00605080039k704c0c08gb87640d1205f5bd1@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0605080555020.6403@gandalf.stny.rr.com>
References: <ae649ba00605080039k704c0c08gb87640d1205f5bd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 May 2006, Krishna Chaitanya wrote:

> Hi All!
>
> I am interested to work on real-time applications.
> Is there any source to understand real-time in linux.
>

Hi Krishna,

Are you looking for documentation or source?

Ingo Molnar maintains the current -rt patch set that makes the vanilla
linux kernel real-time.

You can get the source from here:

  http://people.redhat.com/mingo/realtime-preempt/

Or if you have the latest version of ketchup you can just do the following
in a empty directory:

  $ ketchup 2.6.16-rt20

Which would bring you upto the current latest of the patch (as of this
email).

-- Steve

