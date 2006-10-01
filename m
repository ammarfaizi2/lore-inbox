Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWJAS6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWJAS6h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWJAS6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:58:37 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:35635 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932199AbWJAS6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:58:35 -0400
Subject: Re: Announce: gcc bogus warning repository
From: Daniel Walker <dwalker@mvista.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45200CC8.2030404@garzik.org>
References: <451FC657.6090603@garzik.org>
	 <1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20061001111226.3e14133f.akpm@osdl.org>  <452005E7.5030705@garzik.org>
	 <1159727188.24767.9.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <45200CC8.2030404@garzik.org>
Content-Type: text/plain
Date: Sun, 01 Oct 2006 11:58:33 -0700
Message-Id: <1159729113.24767.14.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 14:45 -0400, Jeff Garzik wrote:

> That doesn't address my question at all.

Did you have a question?

> If there is no difference between real non-init bugs and bogus warnings, 
> then a config option doesn't make any difference at all, does it?  Real 
> bugs are still hidden either way:  if the warnings are turned on, the 
> bugs are lost in the noise.  if the warnings are turned off, the bugs 
> are completely hidden.

If you turn the warnings on, at least you have a chance to see a warning
even if it's mixed with others.

Daniel

