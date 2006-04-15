Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWDOLPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWDOLPV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 07:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWDOLPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 07:15:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20101 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932486AbWDOLPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 07:15:19 -0400
Subject: Re: GPL issues
From: Arjan van de Ven <arjan@infradead.org>
To: Mark Lord <liml@rtr.ca>
Cc: Mark Lord <lkml@rtr.ca>, Joshua Hudson <joshudson@gmail.com>,
       Ramakanth Gunuganti <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <443ECDE3.5030805@rtr.ca>
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
	 <20060411230642.GV23222@vasa.acc.umu.se>
	 <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com>
	 <443C716C.1060103@rtr.ca> <1144819887.3089.0.camel@laptopd505.fenrus.org>
	 <443ECDE3.5030805@rtr.ca>
Content-Type: text/plain
Date: Sat, 15 Apr 2006 13:15:13 +0200
Message-Id: <1145099714.3046.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 18:17 -0400, Mark Lord wrote:
> Arjan van de Ven wrote:
> > On Tue, 2006-04-11 at 23:18 -0400, Mark Lord wrote:
> >> Joshua Hudson wrote:
> >>> On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
> >>>> OK, simplified rules; if you follow them you should generally be OK:
> >> ..
> >>>> 3. Userspace code that uses interfaces that was not exposed to userspace
> >>>> before you change the kernel --> GPL (but don't do it; there's almost
> >>>> always a reason why an interface is not exported to userspace)
> >>>>
> >>>> 4. Userspace code that only uses existing interfaces --> choose
> >>>> license yourself (but of course, GPL would be nice...)
> >> Err.. there is ZERO difference between situations 3 and 4.
> >> Userspace code can be any license one wants, regardless of where
> >> or when or how the syscalls are added to the kernel.
> > 
> > that is not so clear if the syscalls were added exclusively for this
> > application by the authors of the application....
> 
> Neither the GPL nor the kernel's COPYING file restricts anyone
> from making kernel changes.  In fact, the GPL expressly permits
> anyone to modify the kernel.  So how the syscalls get there is
> of zero relevance here.

it IS relevant is the change that adds them is seen as being part of the
other work. See clause 2 :)


