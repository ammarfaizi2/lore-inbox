Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTGCOhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTGCOhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:37:11 -0400
Received: from ida.rowland.org ([192.131.102.52]:9732 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263761AbTGCOhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:37:09 -0400
Date: Thu, 3 Jul 2003 10:51:34 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030702221219.GB10072@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0307031048380.4852-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, Greg KH wrote:

> This is now in 2.5.74.  Combined with the module reference patch for
> attributes that I just posted I now think that the problems discussed in
> this thread are solved, right?

Yes.  Any remaining difficulties are more-or-less internal SCSI matters.
I'm glad that, annoying though it may have been for some people, this
conversation had some positive results.

And by the way, I was serious about that offer of contributing to the 
documentation once you and Pat have added your current updates.

Alan Stern

