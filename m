Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265524AbTFWVZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266197AbTFWVXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:23:01 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41361 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266193AbTFWVWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:22:54 -0400
Date: Mon, 23 Jun 2003 14:36:55 -0700
From: Greg KH <greg@kroah.com>
To: Lesley van Zijl <zyl@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb memory pen broken since 2.5.72?
Message-ID: <20030623213655.GA10891@kroah.com>
References: <200306231803.42338.zyl@xs4all.nl> <20030623182354.GA10089@kroah.com> <200306232326.02007.zyl@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306232326.02007.zyl@xs4all.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 11:26:02PM +0000, Lesley van Zijl wrote:
> well bk1 was released a few minutes/hours ago, and there aren't any changes 
> for usb in there, so I'll wait for bk2 and fill in the bug report right away.

No, it was a scsi core fix for this problem.  Please test it if you can.

thanks,

greg k-h
