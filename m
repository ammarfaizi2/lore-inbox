Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTFBUQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTFBUQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:16:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:37507 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261872AbTFBUQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:16:28 -0400
Subject: Re: [PATCH] pci bridge class code
From: Mark Haverkamp <markh@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Pat Mochel <mochel@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030530231348.GA22049@kroah.com>
References: <1054239461.28608.74.camel@markh1.pdx.osdl.net>
	 <20030530231348.GA22049@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054585856.29244.0.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jun 2003 13:30:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-30 at 16:13, Greg KH wrote:
> On Thu, May 29, 2003 at 01:17:42PM -0700, Mark Haverkamp wrote:
> > This adds pci-pci bridge driver model class code.  Entries appear in 
> > /sys/class/pci_bridge.
> 
> Nice, but I don't see the need for the extra class information, as it
> doesn't really give us anything new, right?  So without the class stuff
> might be nice.
> 

I'm not sure I understand what you are saying here.  Could you clarify?

Thanks,
Mark.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Mark Haverkamp <markh@osdl.org>

