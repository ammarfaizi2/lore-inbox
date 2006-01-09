Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWAIN5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWAIN5w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWAIN5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:57:52 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:14323 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S964770AbWAIN5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:57:51 -0500
Date: Mon, 09 Jan 2006 08:57:14 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: Is Sony violating Linux GPL?
In-reply-to: <dpto0m$ck3$1@sea.gmane.org>
To: Salvador Fandino <sfandino@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <1136815034.1043.42.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <dpto0m$ck3$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 14:22 +0100, Salvador Fandino wrote:
> Then I started mailing Vaio technical support (support@vaio-link.com),
> asking for the drivers source code, and after several mails they just
> refused to give me the drivers source code because "These drivers are
> directly delivered to us by the manufacturers of the hardware and
> modified by us and therefore we are not obliged to supply any source
> code for these drivers".
> 
> I am not an expert on Linux internals but I doubt a driver for this kind
> of device could be developed independently enough of the kernel to not
> be considered a derived work, so is Sony violating the Linux license?

They are correct. The deal with modules is they don't have to GPL them.

It's also not entirely impossible for them to use stock kernel source to
build a simple boot system for just a media player.

What would be nice is if Sony or someone would push this hardware
manufacturer to open up their drivers.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

