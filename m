Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTJ2Dok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 22:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTJ2Dok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 22:44:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:29571 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261787AbTJ2Doi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 22:44:38 -0500
Date: Tue, 28 Oct 2003 19:44:02 -0800
From: Greg KH <greg@kroah.com>
To: Burjan Gabor <buga@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 usbserial/pl2303 oops
Message-ID: <20031029034402.GB11297@kroah.com>
References: <20031027083406.GA9326@odin.sis.hu> <20031027234233.GB3408@kroah.com> <20031029001731.GA20355@odin.sis.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031029001731.GA20355@odin.sis.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 01:17:31AM +0100, Burjan Gabor wrote:
> On Mon, Oct 27, 2003 at 03:42:34PM -0800, Greg KH wrote:
>  
> > Can you try 2.4.23-pre8 and see if that fixes your problem?
> 
> 2.4.23-pre8 fixed that, so the serial emulation is working now.
> 
> How can I grove the serial baud rate?  After I change the baud rate over
> 9600 bps in minicom, I see only the noise and cannot communicate with
> the built-in modem of my phone.  In the phone I can't force the
> communication speed, so I have to use some software solution.

"grove"?  What does that mean?

Have you read the Linux Serial Programming HOWTO?

greg k-h
