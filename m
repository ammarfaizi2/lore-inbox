Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTJ2Doj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 22:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTJ2Doi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 22:44:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:29315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261731AbTJ2Doh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 22:44:37 -0500
Date: Tue, 28 Oct 2003 19:42:55 -0800
From: Greg KH <greg@kroah.com>
To: Christian =?iso-8859-1?Q?K=F6gler?= 
	<christian.koegler@unibw-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 usbserial/pl2303 oops
Message-ID: <20031029034255.GA11297@kroah.com>
References: <3F9F0753.10207@unibw-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F9F0753.10207@unibw-muenchen.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 01:18:27AM +0100, Christian Kögler wrote:
> I have got the same problem with my usb-towitoko (pl2303).
> I had this bug with 2.4.20, 21 and 22
> After reading, an oops appeared.

Again, try 2.4.23-pre8.  Let me know if that fixes it for you or not.

thanks,

greg k-h
