Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVJROWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVJROWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVJROWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:22:32 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49340 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750756AbVJROWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:22:32 -0400
Date: Tue, 18 Oct 2005 10:22:31 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Serge <sjb@druzhba.pptus.ru>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Kernel crash after load usb-ohci module.
In-Reply-To: <4354EFFA.4080903@druzhba.pptus.ru>
Message-ID: <Pine.LNX.4.44L0.0510181021370.4862-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005, Serge wrote:

> 1. Summary: Kernel crash after load usb-ohci module.
> 
> 2. Description: I have Slackware 10.2 standart kernel (bare.i). After adding kernel module usb-uhci (modprobe usb-ohci) I get kernel crash:
> 	"kernel BUG at usb-ohci.h:464!"
> 
> 3. Keywords: module usb-ohci
> 
> 4. Kernel version: Linux version 2.4.31 (root@tree) (gcc version 3.3.5) #6 Sun Jun 5 19:04:47 PDT 2005

Try turning off the Legacy USB Support settings in your computer's BIOS.

Alan Stern

