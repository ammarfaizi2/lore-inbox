Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVLUWFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVLUWFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVLUWFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:05:42 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:7113 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932226AbVLUWFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:05:41 -0500
Subject: Re: 2.6.15-rc5 and later: USB mouse IRQ post kills the computer
	post resume.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Greg KH <greg@kroah.com>
Cc: vojtech@ucw.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051221213342.GA8315@kroah.com>
References: <1135199640.9616.21.camel@localhost>
	 <20051221213342.GA8315@kroah.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1135202541.9616.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 22 Dec 2005 08:02:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg.

On Thu, 2005-12-22 at 07:33, Greg KH wrote:
> On Thu, Dec 22, 2005 at 07:14:01AM +1000, Nigel Cunningham wrote:
> > Hi Vojtech.
> > 
> > I have a HT box with USB mouse support built as modules. Beginning with
> > 2.6.15-rc5 (maybe slightly earlier) a suspend/resume cycle makes the USB
> > mouse get in an invalid state, such that I get a gazillion messages in
> > the logs saying "unexpected IRQ trap at vector 99", or in some
> > alternately a hard hang. No work around found yet. Are you the right man
> > to talk to, or is Greg? (Spose I should cc him, so I'll add that now). I
> > can use kdb if it's helpful. Would you like my kconfig?
> 
> This should be taken to the linux-usb-devel list, that's the best place
> for it.

Okee doke. I'll resend there.

Regards,

Nigel

