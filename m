Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWJGFvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWJGFvq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWJGFvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:51:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:13229 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932284AbWJGFvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:51:46 -0400
Date: Fri, 6 Oct 2006 22:51:22 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       p.hardwick@option.com
Subject: Re: [PATCH 1/2] Char: nozomi, Lindent the code
Message-ID: <20061007055122.GA22518@kroah.com>
References: <54335498213213@wsc.cz> <20061006193955.207674da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006193955.207674da.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 07:39:55PM -0700, Andrew Morton wrote:
> On Sat,  7 Oct 2006 01:53:58 +0200 (CEST)
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
> > [on the top of nozomi-use-tty-wakeup]
> > 
> > nozomi, Lindent the code
> > 
> > Use script/Lindent to indent nozomi driver.
> > 
> > Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> > 
> > ---
> > commit e7e58c9f0d3ce7bed7f8c4b1921da37d65e3ee8f
> > tree c0021b53033d27540ed9211a85905ae36ce5668e
> > parent b19884f570ea41ff9100cc56962e8d6f435e2337
> > author Jiri Slaby <jirislaby@gmail.com> Sat, 07 Oct 2006 01:47:22 +0200
> > committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 07 Oct 2006 01:47:22 +0200
> > 
> >  drivers/char/nozomi.c | 2759 ++++++++++++++++++++++++++-----------------------
> >  1 files changed, 1446 insertions(+), 1313 deletions(-)
> 
> eep, this is all too hard while it's in Greg's tree.
> 
> Greg: run Lindent ;)

Ok, now done, sorry about that.

Jiri, don't worry about the c++ comments right now, there are worse
issues with this driver at the moment...

I'll fix them all up before this driver goes into the tree.

thanks,

greg k-h
