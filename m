Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTFGAC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTFGAC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:02:58 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:39306 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262390AbTFGAC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:02:57 -0400
Date: Fri, 6 Jun 2003 17:12:02 -0700
From: Greg KH <greg@kroah.com>
To: Timothy Miller <miller@techsource.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write can block)
Message-ID: <20030607001202.GB14475@kroah.com>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDE0E85.7090601@techsource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 11:21:41AM -0400, Timothy Miller wrote:
> 
> Perhaps it would be good to have an explanation for the relative 
> importance of placing braces and else on the same line as compared to 
> other formatting standards.

Please read Documentation/CodingStyle.

If you want more justification, read my OLS 2001 paper.

Hope this helps,

greg k-h
