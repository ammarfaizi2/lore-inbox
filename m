Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUATXr2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbUATXr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:47:27 -0500
Received: from [24.35.117.106] ([24.35.117.106]:58501 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263310AbUATXr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:47:26 -0500
Date: Tue, 20 Jan 2004 18:47:02 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: GCS <gcs@lsc.hu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5
In-Reply-To: <20040120230907.GA20425@lsc.hu>
Message-ID: <Pine.LNX.4.58.0401201842490.9398@localhost.localdomain>
References: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
 <20040120230907.GA20425@lsc.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jan 2004, GCS wrote:

> On Tue, Jan 20, 2004 at 05:56:42PM -0500, Thomas Molina <tmolina@cablespeed.com> wrote:
> > Finding module dependencies:  cat: 
> > /sys//devices/pci0000:00/0000:00:07.2/usb1/bNumConfigurations: No such 
> > file or directory
> > /etc/hotplug/usb.agent: line 144: [: too many arguments
>  I think you use Debian, and it's a bug in their scripts, not in the
> kernel itself.

I use RedHat Fedora Core 1 on this machine actually.  It might well be a 
problem with the scripts, but I don't get these messages under 2.4.X nor 
under 2.6.0 bitkeeper.  
