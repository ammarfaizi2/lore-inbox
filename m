Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWDXTaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWDXTaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDXTaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:30:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40328 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751158AbWDXTa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:30:29 -0400
Date: Mon, 24 Apr 2006 20:30:28 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Gary Poppitz <poppitzg@iomega.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-ID: <20060424193028.GC27946@ftp.linux.org.uk>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 01:16:26PM -0600, Gary Poppitz wrote:
> I have the task of porting an existing file system to Linux. This  
> code is in C++ and I have noticed that the Linux kernel has
> made use of C++ keywords and other things that make it incompatible.
> 
> I would be most willing to point out the areas that need adjustment  
> and supply patch files to be reviewed.
> 
> What would be the best procedure to accomplish this?

cat same_old_stuff >/dev/null and save the bandwidth...
