Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVERQFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVERQFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVERQEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:04:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:4245 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262317AbVERQD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:03:29 -0400
Date: Wed, 18 May 2005 09:09:30 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux.bkbits.net question: mapping cset to kernel version?
Message-ID: <20050518160930.GA16756@kroah.com>
References: <428B4D14.2030104@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B4D14.2030104@ammasso.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 09:11:32AM -0500, Timur Tabi wrote:
> Given a particular file and a particular bitkeeper revision for the file, 
> how can I tell which version of the kernel incorporated that changeset?
> 
> In particular, I want to know about revision 1.65 of mm/rmap.c, which can 
> be seen at 
> http://linux.bkbits.net:8080/linux-2.6/diffs/mm/rmap.c@1.65?nav=index.html|src/|src/mm|hist/mm/rmap.c
> 
> I want to know what the first version of Linux is to incorporate that 
> change.
> 
> And please don't tell me to do a diff on all the 2.6 versions, because 
> that's not efficient.

But that's how you have to do it, sorry.  You have the patches, why
can't you just use grep?  :)

Good luck,

greg k-h
