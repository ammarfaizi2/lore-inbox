Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRJYPtA>; Thu, 25 Oct 2001 11:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275178AbRJYPsv>; Thu, 25 Oct 2001 11:48:51 -0400
Received: from zok.sgi.com ([204.94.215.101]:34773 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S275224AbRJYPsi>;
	Thu, 25 Oct 2001 11:48:38 -0400
Message-Id: <200110251545.f9PFjKm16659@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Jakub Jelinek <jakub@redhat.com>
cc: Steve Lord <lord@sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Frontgate Lab <mdiwan@wagweb.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel compiler 
In-Reply-To: Message from Jakub Jelinek <jakub@redhat.com> 
   of "Thu, 25 Oct 2001 11:46:30 EDT." <20011025114630.K25384@devserv.devel.redhat.com> 
Date: Thu, 25 Oct 2001 10:45:20 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Oct 25, 2001 at 10:27:18AM -0500, Steve Lord wrote:
> > Just for information, none of the Redhat compilers (the 2.96 leg) build
> > all of XFS correctly, see this bug for info:
> > 
> > http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=54571
> 
> Yeah, but it is a longstanding reload bug you can get bitten on other code
> in 2.95.x, 3.0.x or 3.1 too, you just have to stress the compiler hard and
> have bad luck.
> 
> 	Jakub

OK thanks, good to know we are stressing the compilers ;-)
Fortunately it appears to be rare enough in XFS that most
people never get bitten by it.

Steve



