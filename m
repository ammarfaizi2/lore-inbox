Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbTFWVlM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbTFWVlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:41:11 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:7686 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S266201AbTFWVlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:41:08 -0400
From: Lesley van Zijl <zyl@xs4all.nl>
To: Greg KH <greg@kroah.com>
Subject: Re: usb memory pen broken since 2.5.72?
Date: Mon, 23 Jun 2003 23:53:57 +0000
User-Agent: KMail/1.5.2
References: <200306231803.42338.zyl@xs4all.nl> <200306232326.02007.zyl@xs4all.nl> <20030623213655.GA10891@kroah.com>
In-Reply-To: <20030623213655.GA10891@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306232353.57539.zyl@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried the bk1 patch. and it gave me the exact same output



On Monday 23 June 2003 21:36, Greg KH wrote:
> On Mon, Jun 23, 2003 at 11:26:02PM +0000, Lesley van Zijl wrote:
> > well bk1 was released a few minutes/hours ago, and there aren't any
> > changes for usb in there, so I'll wait for bk2 and fill in the bug report
> > right away.
>
> No, it was a scsi core fix for this problem.  Please test it if you can.
>
> thanks,
>
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

