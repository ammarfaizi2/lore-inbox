Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWAIU3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWAIU3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAIU3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:29:10 -0500
Received: from ns1.idleaire.net ([65.220.16.2]:15569 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S1751319AbWAIU3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:29:09 -0500
Subject: Re: Athlon 64 X2 cpuinfo oddities
From: Dave Dillow <dave@thedillows.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com>
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 15:29:07 -0500
Message-Id: <1136838548.6029.4.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2006 20:28:52.0772 (UTC) FILETIME=[4E5F6640:01C6155B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 21:18 +0100, Jesper Juhl wrote:
> Second thing I find slightly odd is the lack of "sse3" in the "flags" list.
> I was under the impression that all AMD Athlon 64 X2 CPU's featured SSE3?
> Is it a case of:
>  a) Me being wrong, not all Athlon 64 X2's feature SSE3?
>  b) The CPU actually featuring SSE3 but Linux not taking advantage of it?
>  c) The CPU features SSE3 and it's being utilized, but /proc/cpuinfo
> doesn't show that fact?
>  d) Something else?

Can't help you with the rest, but SSE3 is called "pni" in cpuinfo for
historical reasons, IIRC.
-- 
Dave Dillow <dave@thedillows.org>

