Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUAIRBC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 12:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbUAIRBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 12:01:02 -0500
Received: from [212.239.224.221] ([212.239.224.221]:10119 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262888AbUAIRA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 12:00:59 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18]: Reiserfs: vs-2120: add_save_link: insert_item returned -28
Date: Fri, 9 Jan 2004 18:00:55 +0100
User-Agent: KMail/1.5.4
Cc: reiserfs-list@namesys.com
References: <200401091622.41352.lkml@kcore.org>
In-Reply-To: <200401091622.41352.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401091800.55426.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 January 2004 16:22, Jan De Luyck wrote:
> Hello list,
>
> Today I discovered I could no longer create files on one of my boxes, which
> still runs 2.4.18 (box is too far away to upgrade right now). It gives me
> 'disk full' messages.
>
> The following message is all over my logs since January 3:
>
> vs-2120: add_save_link: insert_item returned -28
>
> I can't seem to find much on this issue, is this a bug in reiserfs (which
> is fixed in a later version)? Is something wrong with the fs itself?
>
> Thanks for answers.

Nevermind this... I was looking at the wrong partition... for half an hour.... 

:-(

Jan
-- 
My apologies if I sound angry.  I feel like I'm talking to a void.
	-- Avery Pennarun

