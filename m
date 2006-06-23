Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932845AbWFWG1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbWFWG1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 02:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932853AbWFWG1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 02:27:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932845AbWFWG1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 02:27:24 -0400
Date: Thu, 22 Jun 2006 23:27:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB fixes for suspend issues
In-Reply-To: <20060623055737.GA29631@kroah.com>
Message-ID: <Pine.LNX.4.64.0606222326450.6483@g5.osdl.org>
References: <20060623055737.GA29631@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Greg KH wrote:
>
> Here are the two patches that fix the suspend issue and the USB oops
> issue in your current tree.

Ack. My box works again with this.

		Linus
