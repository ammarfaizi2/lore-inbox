Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTFIQ0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTFIQ0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:26:36 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:42391 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264515AbTFIQ0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:26:35 -0400
Date: Mon, 9 Jun 2003 18:39:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Timothy Miller <miller@techsource.com>
Cc: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write can block)
Message-ID: <20030609163959.GA13811@wohnheim.fh-wedel.de>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com> <20030607001202.GB14475@kroah.com> <3EE4B4C3.80902@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EE4B4C3.80902@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 June 2003 12:24:35 -0400, Timothy Miller wrote:
> 
> One thing I wanted to mention, however, is that your tongue-in-cheek 
> style doesn't help you.  Coding style is something that needs to be 
> taken seriously when you're setting standards.

Coding style is secondary.  It doesn't effect the compiled code.  That
simple.

In the case of the kernel, there is quite a bit of horrible coding
style.  But a working device driver for some hardware is always better
that no working device driver for some hardware, and if enforcing the
coding style more results is scaring away some driver writers, the
style clearly loses.

Jörn

-- 
They laughed at Galileo.  They laughed at Copernicus.  They laughed at
Columbus. But remember, they also laughed at Bozo the Clown.
-- unknown
