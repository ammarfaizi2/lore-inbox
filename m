Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUAVBTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 20:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUAVBTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 20:19:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:29616 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266144AbUAVBT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 20:19:29 -0500
Date: Wed, 21 Jan 2004 15:56:55 -0800
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
Message-ID: <20040121235655.GF1958@kroah.com>
References: <10745567662012@kroah.com> <10745567661358@kroah.com> <20040121225012.1addb5c7.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121225012.1addb5c7.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 10:50:12PM +0100, Jean Delvare wrote:
> > Also note that I slightly altered the condition to display the PCILynx
> > comment. I think it's more logical that way. Without it, the user
> > could get the message he/she needs I2C, go to enable it, come back and
> > still not see the option.
> 
> For the records, please let it be noted that this change is *not* included
> in the patch submitted by Greg.
> 
> That said, I still think it was a good idea. Not that it matters much to
> me since I don't use that driver, but anyway... Who should I contact to
> get it included?

The ieee1394 maintainer?
