Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTJDT3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 15:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTJDT3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 15:29:12 -0400
Received: from havoc.gtf.org ([63.247.75.124]:62871 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262718AbTJDT3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 15:29:09 -0400
Date: Sat, 4 Oct 2003 15:29:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test6-mm3
Message-ID: <20031004192906.GB30371@gtf.org>
References: <20031004021255.3fefbacb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031004021255.3fefbacb.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 02:12:55AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm3/
> 
> . Added the Intel MSI interrupt patch.  This is mainly to get it under
>   test and under review and to provide the Intel developers with a codebase
>   against which to continue working.  Probably nobody has the hardware yet.

MSI cards have been out there for a while, now.
I dunno about the FSB pieces, though...

I could have sworn Intel ICH5 (now released) supports MSI...

	Jeff



