Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbTD1Bdk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbTD1Bdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:33:40 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:59486 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S263160AbTD1Bdj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:33:39 -0400
Date: Sun, 27 Apr 2003 21:45:55 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <yw1xptn7z9m6.fsf@zaphod.guide>
Message-ID: <Pine.BSO.4.44.0304272145110.23296-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 28 Apr 2003, [iso-8859-1] Måns Rullgård wrote:

> > But yeah, basically, something similar to NT's CreateProcess(). For the
> > cases where the one-step process creation is sufficient.
>
> Is that the call that takes dozens of parameters?  Copying :-) that
> is, IMHO, straight against the UNIX philosophy.

Well, it does take quite a few parameters. I wasn't thinking that it be
nearly that messy. See my first message for my original proposal.

L8r,
Mark G.


