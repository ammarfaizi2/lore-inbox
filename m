Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933037AbWFWLK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933037AbWFWLK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933051AbWFWLK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:10:57 -0400
Received: from mail.gmx.net ([213.165.64.21]:56722 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933044AbWFWLK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:10:56 -0400
X-Authenticated: #1490710
Date: Fri, 23 Jun 2006 13:10:54 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
       Git Mailing List <git@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
In-Reply-To: <Pine.LNX.4.64.0606221402140.6483@g5.osdl.org>
Message-ID: <Pine.LNX.4.63.0606231310290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org> <20060622205859.GF21864@pasky.or.cz>
 <Pine.LNX.4.64.0606221402140.6483@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Jun 2006, Linus Torvalds wrote:

> On Thu, 22 Jun 2006, Petr Baudis wrote:
> > 
> > Isn't manually numbering the enum choices somewhat pointless, though?
> > (Actually makes it more difficult to do changes in it later.)
> 
> Yeah, I just mindlessly followed Johannes' original scheme. 

... which wasn't his, to begin with ...

