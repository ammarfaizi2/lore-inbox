Return-Path: <linux-kernel-owner+w=401wt.eu-S1752948AbWLWJhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbWLWJhP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 04:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbWLWJhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 04:37:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1159 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752948AbWLWJhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 04:37:14 -0500
Date: Fri, 22 Dec 2006 20:44:01 +0000
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       david-b@pacbell.net, gregkh@suse.de, seife@suse.de
Subject: Re: Changes to sysfs PM layer break userspace
Message-ID: <20061222204401.GB3960@ucw.cz>
References: <20061219185223.GA13256@srcf.ucam.org> <1166556889.3365.1269.camel@laptopd505.fenrus.org> <20061219194410.GA14121@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219194410.GA14121@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > which userspace is using this btw?
> 
> Ubuntu uses it to disable wireless hardware under certain circumstances. 
> I believe that Suse's powernowd uses it to power down wired ethernet 
> hardware when it's not in use.

I flamed seife for this. It was always broken for 20%-or-so of
hardware. It is _not_ simple to fix.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
