Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSJQOnd>; Thu, 17 Oct 2002 10:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJQOnd>; Thu, 17 Oct 2002 10:43:33 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:62994 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261476AbSJQOnc>; Thu, 17 Oct 2002 10:43:32 -0400
Date: Thu, 17 Oct 2002 16:49:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Daniel Phillips <phillips@arcor.de>, <S@samba.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 
In-Reply-To: <20021017075539.8DE762C0CA@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210171644010.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Oct 2002, Rusty Russell wrote:

> Roman dislikes linking in the kernel.  So did I until I wrote it: it's
> really trivial (esp. compared with the code to coordinate with the
> userspace linker properly).  And it exists today.  The linking takes
> around 200 lines.  But, let's say his solution is 500 lines shorter
> than mine.

I believe you that linking in the kernel is simpler, but so would be a lot
of other things and the part I really dislike is to remove the ability to
keep it in user space.

bye, Roman

