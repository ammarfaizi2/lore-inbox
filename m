Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135687AbRDXQFF>; Tue, 24 Apr 2001 12:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135688AbRDXQEz>; Tue, 24 Apr 2001 12:04:55 -0400
Received: from passat.ndh.net ([195.94.90.26]:60659 "EHLO passat.ndh.net")
	by vger.kernel.org with ESMTP id <S135687AbRDXQEm>;
	Tue, 24 Apr 2001 12:04:42 -0400
Date: Tue, 24 Apr 2001 18:04:37 +0200
From: Alex Riesen <a.riesen@traian.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
Message-ID: <20010424180437.A332@traian.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20010425011132.H1245@zip.com.au> <E14s57p-0002LM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14s57p-0002LM-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 24, 2001 at 04:53:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 04:53:10PM +0100, Alan Cox wrote:
> > 1. email -> sendmail
> > 2. sendmail figures out what it has to do with it. turns out it's deliver
> ...
> 
> > Now, in order for step 4 to be done safely, procmail should be running
> > as the user it's meant to deliver the mail for. for this to happen
> > sendmail needs to start it as that user in step 3 and to do that it
> > needs extra privs, above and beyond that of a normal user.
> 
> 	email -> sendmail
> 	sendmail 'its local' -> spool
Isn't this a good thing to have spam filtered out before it will be
written in spool?

Alex Riesen
