Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263901AbTDVVGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 17:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTDVVGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 17:06:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:20121 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263901AbTDVVGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 17:06:35 -0400
Date: Tue, 22 Apr 2003 14:19:16 -0700
From: Greg KH <greg@kroah.com>
To: David Ford <david+cert@blue-labs.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: scsi HBA driver sym53c8xx didn't set a release method, please fix the template
Message-ID: <20030422211916.GG4701@kroah.com>
References: <3EA56F77.7030805@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA56F77.7030805@blue-labs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 12:36:07PM -0400, David Ford wrote:
> 2> Please use the 'usbfs' filetype instead, the 'usbdevfs' name is 
> deprecated.

Yes, this has been logged in the bug database for a while, along with a
description of the problem, and why it's a bit tough to solve...

thanks,

greg k-h
