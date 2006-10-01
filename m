Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWJATDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWJATDN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWJATDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:03:13 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:17972 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932212AbWJATDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:03:12 -0400
Subject: Re: Announce: gcc bogus warning repository
From: Daniel Walker <dwalker@mvista.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061001190034.GB29920@ftp.linux.org.uk>
References: <451FC657.6090603@garzik.org>
	 <1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20061001111226.3e14133f.akpm@osdl.org> <452005E7.5030705@garzik.org>
	 <1159727188.24767.9.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <45200CC8.2030404@garzik.org>
	 <1159729113.24767.14.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20061001190034.GB29920@ftp.linux.org.uk>
Content-Type: text/plain
Date: Sun, 01 Oct 2006 12:03:10 -0700
Message-Id: <1159729390.24767.16.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 20:00 +0100, Al Viro wrote:
> On Sun, Oct 01, 2006 at 11:58:33AM -0700, Daniel Walker wrote:
> > On Sun, 2006-10-01 at 14:45 -0400, Jeff Garzik wrote:
> > 
> > > That doesn't address my question at all.
> > 
> > Did you have a question?
> > 
> > > If there is no difference between real non-init bugs and bogus warnings, 
> > > then a config option doesn't make any difference at all, does it?  Real 
> > > bugs are still hidden either way:  if the warnings are turned on, the 
> > > bugs are lost in the noise.  if the warnings are turned off, the bugs 
> > > are completely hidden.
> > 
> > If you turn the warnings on, at least you have a chance to see a warning
> > even if it's mixed with others.
> 
> And that's better than the current situation in which respects, exactly?

Seeing the warnings is the current situation.

Daniel

