Return-Path: <linux-kernel-owner+w=401wt.eu-S1751895AbWLNB6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWLNB6y (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWLNB6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:58:54 -0500
Received: from mx1.suse.de ([195.135.220.2]:41596 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbWLNB6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:58:53 -0500
Date: Wed, 13 Dec 2006 17:58:32 -0800
From: Greg KH <gregkh@suse.de>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214015832.GA23404@suse.de>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.63.0612140224490.14187@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612140224490.14187@alpha.polcom.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 02:30:26AM +0100, Grzegorz Kulewski wrote:
> Hi,
> 
> I think that...
> 
> On Wed, 13 Dec 2006, Greg KH wrote:
> >From: Greg Kroah-Hartmna <gregkh@suse.de>
> 
> ... (most probably) there...
> 
> >Subject: Notify non-GPL module loading will be going away in January 2008
> >
> >Numerous kernel developers feel that loading non-GPL drivers into the
> >kernel violates the license of the kernel and their copyright.  Because
> >of this, a one year notice for everyone to address any non-GPL
> >compatible modules has been set.
> >
> >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ... or (less probably) there...
> 
> is a typo in your name. :-)

Heh, thanks.  I've also fixed up the wording in the
feature-removal-schedule.txt file to say:
	What:  non-GPL-licensed modules will no longer be loaded.

The wording I had before was not very easy to understand.

> PS. Are you _really_ sure you want this change accepted into mainline 
> kernel?

Yes, I do.

thanks,

greg k-h
