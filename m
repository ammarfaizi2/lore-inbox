Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUI0VY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUI0VY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUI0Umb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:42:31 -0400
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:39315
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S267356AbUI0UhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:37:21 -0400
Date: Mon, 27 Sep 2004 16:37:13 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Christoph Hellwig <hch@infradead.org>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
In-Reply-To: <20040927211750.A27684@infradead.org>
Message-ID: <Pine.LNX.4.61.0409271633330.8383@xanadu.home>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
 <20040927211750.A27684@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004, Christoph Hellwig wrote:

> 
> From loooking at the gcc and binutils lists it seems codesourcery is pushing
> through all the ARM EABI bullshit.  Maybe we can persuade hjl to keep it
> out of his bintuils release?  So far we've been served far better with them
> on Linux anyway..

Or maybe we should strongly suggest codesourcery to add a command line 
option to be able to disable those new "features" especially since 
they're not always welcome like for the Linux kernel build.


Nicolas
