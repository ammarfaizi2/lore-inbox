Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWF3UNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWF3UNl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWF3UNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:13:41 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:36487 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932161AbWF3UNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:13:40 -0400
Date: Fri, 30 Jun 2006 16:13:30 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed	EvDO
	transfers
In-reply-to: <ada7j2yfm05.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Message-id: <1151698410.3285.469.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<ada7j2yfm05.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 13:04 -0700, Roland Dreier wrote:
>  > +		/* something happened, so free up the memory for this urb /*
> 
> an obvious glitch here at the end of the line...
Oops. Sorry 'bout that.. that comment had some more stuff that no longer
applies, I edited it just before I submitted the patch.

I'll make sure to at least compile test before submitting in future....


