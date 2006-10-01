Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWJATAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWJATAp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWJATAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:00:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12710 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932202AbWJATAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:00:44 -0400
Date: Sun, 1 Oct 2006 20:00:34 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Announce: gcc bogus warning repository
Message-ID: <20061001190034.GB29920@ftp.linux.org.uk>
References: <451FC657.6090603@garzik.org> <1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20061001111226.3e14133f.akpm@osdl.org> <452005E7.5030705@garzik.org> <1159727188.24767.9.camel@c-67-180-230-165.hsd1.ca.comcast.net> <45200CC8.2030404@garzik.org> <1159729113.24767.14.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159729113.24767.14.camel@c-67-180-230-165.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 11:58:33AM -0700, Daniel Walker wrote:
> On Sun, 2006-10-01 at 14:45 -0400, Jeff Garzik wrote:
> 
> > That doesn't address my question at all.
> 
> Did you have a question?
> 
> > If there is no difference between real non-init bugs and bogus warnings, 
> > then a config option doesn't make any difference at all, does it?  Real 
> > bugs are still hidden either way:  if the warnings are turned on, the 
> > bugs are lost in the noise.  if the warnings are turned off, the bugs 
> > are completely hidden.
> 
> If you turn the warnings on, at least you have a chance to see a warning
> even if it's mixed with others.

And that's better than the current situation in which respects, exactly?
