Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTJ2ARe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 19:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTJ2ARe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 19:17:34 -0500
Received: from odin.sis.hu ([212.92.23.29]:28049 "EHLO odin.sis.hu")
	by vger.kernel.org with ESMTP id S261802AbTJ2ARd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 19:17:33 -0500
Date: Wed, 29 Oct 2003 01:17:31 +0100
From: Burjan Gabor <buga@elte.hu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 usbserial/pl2303 oops
Message-ID: <20031029001731.GA20355@odin.sis.hu>
References: <20031027083406.GA9326@odin.sis.hu> <20031027234233.GB3408@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027234233.GB3408@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 03:42:34PM -0800, Greg KH wrote:
 
> Can you try 2.4.23-pre8 and see if that fixes your problem?

2.4.23-pre8 fixed that, so the serial emulation is working now.

How can I grove the serial baud rate?  After I change the baud rate over
9600 bps in minicom, I see only the noise and cannot communicate with
the built-in modem of my phone.  In the phone I can't force the
communication speed, so I have to use some software solution.

RTFM with a pointer to any relevant documentation is sufficient for me.

Thank for your help,

Gabor
