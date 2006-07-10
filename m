Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWGJQBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWGJQBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbWGJQBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:01:50 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:30981 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965178AbWGJQBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:01:48 -0400
Date: Mon, 10 Jul 2006 12:01:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Brown, Len" <len.brown@intel.com>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       <johnstul@us.ibm.com>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [linux-pm] [BUG] sleeping function called from invalid context
 during resume
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECFDB0@hdsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.44L0.0607101200590.7513-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Brown, Len wrote:

> >> http://bugzilla.kernel.org/show_bug.cgi?id=3469
> >> 
> >> Make acpi_os_allocate() into an inline function to
> >> allow /proc/slab_allocators to work.
> >
> >Another problem with this patch; it doesn't compile.
> 
> Hmmm, to you refer to the patch on the bug-id, the one
> in e-mail, or the one checked into git?
> 
> My appologies if they don't match.  I've compiled 
> this into a few dozen kernels at this point.

I was referring to the patch in the email.

Alan Stern

