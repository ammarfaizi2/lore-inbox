Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTESQyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTESQyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:54:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:11144 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262288AbTESQyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:54:09 -0400
Date: Mon, 19 May 2003 10:05:36 -0700
From: Greg KH <greg@kroah.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69+ and USB freezes machine
Message-ID: <20030519170536.GB24823@kroah.com>
References: <87znlj5gbc.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87znlj5gbc.fsf@lapper.ihatent.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 01:25:27PM +0200, Alexander Hoogerhuis wrote:
> 
> Running 2.5.69 and later -mm patches USD will hang the machine solid
> during shutdown. Using a camera I've gotten this output from the
> console at the time it hangs:

Known problem, see the linux-usb-devel for a possible patch to fix this.
It is being worked on.

thanks,

greg k-h
