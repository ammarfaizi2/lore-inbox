Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUJGUbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUJGUbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUJGU2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:28:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:45250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268049AbUJGU1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:27:40 -0400
Subject: Re: Probable module bug in linux-2.6.5-1.358
From: Stephen Hemminger <shemminger@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1097175596.31547.111.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
	 <1097175903.29576.12.camel@localhost.localdomain>
	 <1097175596.31547.111.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Open Source Development Lab
Date: Thu, 07 Oct 2004 13:27:47 -0700
Message-Id: <1097180867.29576.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 19:59 +0100, Alan Cox wrote:
> On Iau, 2004-10-07 at 20:05, Stephen Hemminger wrote:
> > --------------
> > /*
> >  *   Since some in the Linux-kernel development group want to play
> >  *   lawyer, and require that a GPL License exist for every kernel
> >  *   module,  I provide the following:
> >  *
> >  *   Everything in this file (only) is released under the so-called
> >  *   GNU Public License, incorporated herein by reference.
> >  *
> >  *   Now, we just link this with any proprietary code and everybody
> >  *   but the lawyers are happy.
> >  */
> 
> What a fascinating object. I hope thats not reflective of OSDL policy 8)

That's from Richard's license.c in the source he attached.
All copies of that code have been deleted from here because the rest of
it is proprietary.

