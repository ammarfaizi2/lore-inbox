Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262050AbSIYSfC>; Wed, 25 Sep 2002 14:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262051AbSIYSfC>; Wed, 25 Sep 2002 14:35:02 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:18384 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262050AbSIYSfC>; Wed, 25 Sep 2002 14:35:02 -0400
Date: Wed, 25 Sep 2002 13:40:11 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Page table sharing
Message-ID: <59570000.1032979211@baldur.austin.ibm.com>
In-Reply-To: <200209252013.17714.gjwucherpfennig@gmx.net>
References: <200209252013.17714.gjwucherpfennig@gmx.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, September 25, 2002 20:12:36 +0200 "Gerold J. Wucherpfennig"
<gjwucherpfennig@gmx.net> wrote:

> What about page table sharing? Does anybody still care about this?
> 
> The patch from Daniel Phillips
> (http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35)
> is a few month old and I can't see any progress.
> 
> Sorry, I'm not a kernel expert, so I can't help.
> But page table sharing is still listed as betaware at the
> Linux Kernel 2.5 Status page (http://kernelnewbies.org/status/latest.html)
> and Page Table sharing isn't marked post Halloween.
> 
> Some comments from Daniel Phillips or Dave McCracken?

I'm working on it.  I sent out a patch to the mm list a few weeks ago, but
it didn't have the locking right.  I'm in the proces of finishing an
improved version with new locking.  I'll send a snapshot of it out when I
can make it stop oopsing :)

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

