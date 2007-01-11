Return-Path: <linux-kernel-owner+w=401wt.eu-S1751062AbXAKRpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbXAKRpW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbXAKRpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:45:21 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49857 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbXAKRpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:45:20 -0500
Date: Thu, 11 Jan 2007 09:44:16 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: Christoph Hellwig <hch@infradead.org>, jeff@garzik.org, csnook@redhat.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] atl1: Header files for Attansic L1 driver
Message-ID: <20070111094416.0dc4b316@localhost>
In-Reply-To: <20070111165330.GA6191@osprey.hogchain.net>
References: <20070111004137.GC2624@osprey.hogchain.net>
	<20070111092704.GB3141@infradead.org>
	<20070111165330.GA6191@osprey.hogchain.net>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 10:53:30 -0600
Jay Cliburn <jacliburn@bellsouth.net> wrote:

> On Thu, Jan 11, 2007 at 09:27:04AM +0000, Christoph Hellwig wrote:
> > On Wed, Jan 10, 2007 at 06:41:37PM -0600, Jay Cliburn wrote:
> > > +/**
> > > + * atl1.h - atl1 main header
> > 
> > Please remove these kind of comments, they get out of date far too soon
> > and don't really help anything.  (Also everywhere else in the driver)
> 
> Is your concern here with the filename portion of the comment only, or
> with the entire comment including the copyright and other material?
> 
> Jay

Comments should not insult the reader by stating the obvious.
