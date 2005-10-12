Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVJLA6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVJLA6B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVJLA6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:58:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39573 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750920AbVJLA6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:58:00 -0400
Date: Tue, 11 Oct 2005 17:57:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Borislav Petkov <bbpetkov@yahoo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tgraf@suug.ch,
       pablo@eurodev.net
Subject: Re: [was: Linux v2.6.14-rc4] fix textsearch build warning
In-Reply-To: <20051011234948.GX7992@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0510111755330.14597@g5.osdl.org>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org>
 <20051011145454.GA30786@gollum.tnic> <20051011205949.GU7992@ftp.linux.org.uk>
 <20051011230233.GA20187@gollum.tnic> <Pine.LNX.4.64.0510111629490.14597@g5.osdl.org>
 <Pine.LNX.4.64.0510111634070.14597@g5.osdl.org> <20051011234948.GX7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Oct 2005, Al Viro wrote:
>
> On Tue, Oct 11, 2005 at 04:38:14PM -0700, Linus Torvalds wrote:
> > I'll merge the full series after 2.6.14..
> 
> BTW, do you want me to post it now (marked "post-2.6.14") or would you prefer
> to get it right after 2.6.14 gets released?  It's at 20-odd patches by now..

I'd much rather get it after 2.6.14, otherwise I'll just screw up and 
forget about it.

In general, if you act like I've got all the attention span of a slightly 
retarded golden retriever, you'll be pretty close to the mark.

		Linus
