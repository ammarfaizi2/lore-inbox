Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWDLFcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWDLFcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 01:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWDLFcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 01:32:09 -0400
Received: from [4.79.56.4] ([4.79.56.4]:42663 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750804AbWDLFcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 01:32:09 -0400
Subject: Re: GPL issues
From: Arjan van de Ven <arjan@infradead.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Joshua Hudson <joshudson@gmail.com>,
       Ramakanth Gunuganti <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <443C716C.1060103@rtr.ca>
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
	 <20060411230642.GV23222@vasa.acc.umu.se>
	 <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com>
	 <443C716C.1060103@rtr.ca>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 07:31:26 +0200
Message-Id: <1144819887.3089.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 23:18 -0400, Mark Lord wrote:
> Joshua Hudson wrote:
> > On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
> >> OK, simplified rules; if you follow them you should generally be OK:
> ..
> >> 3. Userspace code that uses interfaces that was not exposed to userspace
> >> before you change the kernel --> GPL (but don't do it; there's almost
> >> always a reason why an interface is not exported to userspace)
> >>
> >> 4. Userspace code that only uses existing interfaces --> choose
> >> license yourself (but of course, GPL would be nice...)
> 
> Err.. there is ZERO difference between situations 3 and 4.
> Userspace code can be any license one wants, regardless of where
> or when or how the syscalls are added to the kernel.

that is not so clear if the syscalls were added exclusively for this
application by the authors of the application....


