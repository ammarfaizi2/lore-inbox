Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVC1BvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVC1BvH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 20:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVC1BvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 20:51:07 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:42423 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261664AbVC1Bu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 20:50:59 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Steven Rostedt <rostedt@goodmis.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, Lee Revell <rlrevell@joe-job.com>,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050328013902.GK4285@stusta.de>
References: <20050326182828.GA8540@kroah.com>
	 <1111869274.32641.0.camel@mindpipe> <20050327004801.GA610@kroah.com>
	 <1111885480.1312.9.camel@mindpipe> <20050327032059.GA31389@kroah.com>
	 <1111894220.1312.29.camel@mindpipe> <20050327181056.GA14502@kroah.com>
	 <1111948631.27594.14.camel@localhost.localdomain>
	 <20050327220139.GI4285@stusta.de>
	 <1111967692.27381.8.camel@localhost.localdomain>
	 <20050328013902.GK4285@stusta.de>
Content-Type: text/plain; charset=iso-8859-1
Organization: Kihon Technologies
Date: Sun, 27 Mar 2005 20:50:36 -0500
Message-Id: <1111974636.27381.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 03:39 +0200, Adrian Bunk wrote:

> > Your talking about something completely different.  Yes, it is quite
> > explicit if you modify the source, and distribute it in binary only
> > form.  I'm talking about writing a separate module that links with the
> > GPL code dynamically.  So that the code is compiled different from the
> > GPL code. So the only common part is the API. Now is this a derived
> > work? 
> >...
> 
> My point was a bit different:
> 
> Harald's action was meant as an example, that such things can be brought 
> to court in virtually every country in the world.
> 
> And a court decision in e.g. the USA might not have any influence on a 
> court decision in e.g. Germany.
> 
> Some people seem to think that it was enough if something was OK 
> according to US law - but that's simply wrong.
> 

I understand this quite well since I do business in both the US and
Germany. But I do find the courts quite similar too, from reading the
newspapers in both countries.  But even in the US, things differ from
one court to the next.  Anyway, the problem the GPL may have with
dynamic loading is that the loading is done by the user and not the
distributer, which is who the GPL states is under the obligation of the
license. 

Tschüss,

-- Steve


