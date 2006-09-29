Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWI2LTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWI2LTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 07:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWI2LTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 07:19:11 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:42380 "EHLO
	asav11.insightbb.com") by vger.kernel.org with ESMTP
	id S1161022AbWI2LTK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 07:19:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAN6cHEWBTookLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [GIT PATCH] USB patches for 2.6.18
Date: Fri, 29 Sep 2006 07:19:04 -0400
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20060927200626.GA10018@kroah.com>
In-Reply-To: <20060927200626.GA10018@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609290719.05445.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 16:06, Greg KH wrote:
> drivers/usb/input/trancevibrator.c      |  159 +
>  

Greg,

There is  nothing in this driver that would relate to input subsystem,
can it be moved into drivers/usb/misc?

-- 
Dmitry
