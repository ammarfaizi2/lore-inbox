Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVEFONi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVEFONi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVEFONh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:13:37 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:22236 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261203AbVEFON1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:13:27 -0400
Subject: Re: Empty partition nodes not created (was device node issues with
	recent mm's and udev)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, chrisw@osdl.org, aebr@win.tue.nl,
       "Randy.Dunlap" <rddunlap@osdl.org>, Greg KH <greg@kroah.com>,
       joecool1029@gmail.com, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050506020518.0b0afdc3.akpm@osdl.org>
References: <d4757e6005050219514ece0c0a@mail.gmail.com>
	 <20050503031421.GA528@kroah.com>
	 <20050502202620.04467bbd.rddunlap@osdl.org>
	 <20050506080056.GD4604@pclin040.win.tue.nl>
	 <20050506081009.GX23013@shell0.pdx.osdl.net>
	 <20050506084259.GB25418@apps.cwi.nl>
	 <20050506020518.0b0afdc3.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 May 2005 09:12:47 -0500
Message-Id: <1115388767.4989.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-06 at 02:05 -0700, Andrew Morton wrote:
> > Should it be backed out of 2.6.11.8? Possibly - but if it will be
> > part of 2.6.12 or 2.6.13 then I would be inclined to leave it.
> > 
> > Andrew asks whether it should be removed from -mm.
> 
> It was merged into Linus's tree on March 8th (via bk, thank gawd.  How do
> you find out that sort of info using git?  Generating a full log is
> cheating).

Well, moving offtopic, but it is of relevance to people who use git.
The answer is that the information exists (we can use the commit tree to
reconstruct the file data) but that no-one has yet come up with a file
history viewing tool.  I think David Woodhouse is the closest to
producing one of these, David?

James
 

