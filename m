Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264873AbUD2VDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbUD2VDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUD2VDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:03:15 -0400
Received: from ida.rowland.org ([192.131.102.52]:18436 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264781AbUD2U7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:59:15 -0400
Date: Thu, 29 Apr 2004 16:59:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Martin Hermanowski <martin@mh57.de>
cc: Soeren Sonnenburg <kernel@nn7.de>, Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.6-rc3 still oops on unplugging usb bluetooth
 bcm203x dongle
In-Reply-To: <20040429205351.GJ11077@mh57.de>
Message-ID: <Pine.LNX.4.44L0.0404291658190.1492-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Martin Hermanowski wrote:

> On Thu, Apr 29, 2004 at 03:59:36PM -0400, Alan Stern wrote:
> > 
> > Marcel Holtman is working on this; some other people have reported the 
> > same problem.  Have you been in touch with him?  It appears to be a 
> > problem in the Bluetooth driver, not in the USB stack.
> 
> Are there any patches available? The most recent patch I could find is
> for 2.6.5, and does not change this problem.
> 
> I would like to try the latest version of the bluez-patch, if this can
> help to find the bug.

As I said, Marcel is working on it.  You should ask him there are any 
patches available (but I don't think he's gotten that far yet).

Alan Stern


