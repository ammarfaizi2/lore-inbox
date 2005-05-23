Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVEWFQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVEWFQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 01:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVEWFQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 01:16:11 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:57422 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261850AbVEWFQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 01:16:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi SuperIO chip
Date: Mon, 23 May 2005 00:15:48 -0500
User-Agent: KMail/1.8
Cc: Willy Tarreau <willy@w.ods.org>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <200505220008.j4M08uE9025378@hera.kernel.org> <Pine.LNX.4.58.0505221535370.2307@ppc970.osdl.org> <20050523040905.GH18600@alpha.home.local>
In-Reply-To: <20050523040905.GH18600@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505230015.48938.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 May 2005 23:09, Willy Tarreau wrote:
> Linus,
> 
> On Sun, May 22, 2005 at 03:40:24PM -0700, Linus Torvalds wrote:
> (...)
> > -        Developer's Certificate of Origin 1.0
> > +        Developer's Certificate of Origin 1.1
> (...)
> >  then you just add a line saying
> >  
> >  	Signed-off-by: Random J Developer <random@developer.org>
> 
> Why not change this slightly to something like :
> 
>        DCO-1.1-Signed-off-by: Random J Developer <random@developer.org>
> 
> which would imply that this person has read (and agreed with) version 1.1 ?
>

Ugh, that's ugly, long and redundant. You could have:

      DCO-m.n: Random J Developer <random@developer.org>

but it still looks ugly.   

-- 
Dmitry
