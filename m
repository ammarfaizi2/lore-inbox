Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbSJDBTk>; Thu, 3 Oct 2002 21:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbSJDBTk>; Thu, 3 Oct 2002 21:19:40 -0400
Received: from smtp2.texas.rr.com ([24.93.36.230]:7857 "EHLO
	txsmtp02.texas.rr.com") by vger.kernel.org with ESMTP
	id <S261340AbSJDBTk>; Thu, 3 Oct 2002 21:19:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <kcorry@austin.rr.com>
Reply-To: kcorry@austin.rr.com
To: Greg KH <greg@kroah.com>
Subject: Re: EVMS Submission for 2.5
Date: Thu, 3 Oct 2002 19:39:48 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02100216332002.18102@boiler> <02100316563708.05904@boiler> <20021003230728.GF2289@kroah.com>
In-Reply-To: <20021003230728.GF2289@kroah.com>
MIME-Version: 1.0
Message-Id: <02100319394801.00236@cygnus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 October 2002 18:07, Greg KH wrote:
> On Thu, Oct 03, 2002 at 04:56:37PM -0500, Kevin Corry wrote:
> >     
> > http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/evms/runtime/linux-2.5/
>
> Heh, looks like you ran the thing through Lindent without looking at the
> output.  Lindent is a great place to start, but it does generate lines
> like the following which you will probably want to fix up by hand
> (unless you really want to try to maintain things like this...)

Yep, you guessed it. I'm no big fan of Lindent. In my opinion, it makes some 
really bad choices about how to break long lines (among other things), as 
you've kindly pointed out. But, I had to start somewhere and wanted to get 
something out before I left for the day. Obviously the AIX plugin will need 
some additional attention at some point.

-Kevin
