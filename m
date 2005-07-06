Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVGFEuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVGFEuR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 00:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVGFEuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 00:50:17 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:61097 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S262058AbVGFCgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:36:06 -0400
Message-ID: <41050.127.0.0.1.1120617353.squirrel@localhost>
In-Reply-To: <20050703205955.GB17461@suse.de>
References: <20050630060206.GA23321@kroah.com>
    <34128.127.0.0.1.1120152169.squirrel@localhost>
    <20050630194540.GA15389@suse.de>
    <37114.127.0.0.1.1120166322.squirrel@localhost>
    <20050703205955.GB17461@suse.de>
Date: Tue, 5 Jul 2005 21:35:53 -0500 (CDT)
Subject: Re: [PATCH] add class_interface pointer to add and remove functions
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Greg KH" <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, July 3, 2005 3:59 pm, Greg KH said:
> On Thu, Jun 30, 2005 at 04:18:42PM -0500, John Lenz wrote:
>> Here is a patch that updates every usage of class_interface I could
>> find.
>
> Do you have a patch that will take advantage of this change?  I would
> prefer to have that before accepting this patch.
>

No, not for inclusion.  I needed this change while I was working on the
touchscreen driver for Zaurus (http://www.cs.wisc.edu/~lenz/zaurus).  I
have not yet completed that driver, and am currently working on some other
drivers.  So I won't really have a patch until I (or someone else, we can
always use volunteers!) goes back and tries to work on the touchscreen
driver.

I just thought that since the class API is changing anyway, this API
change could come along.  Otherwise I will resubmit this patch when I (or
someone else) gets around to working on the touchscreen driver.

John

