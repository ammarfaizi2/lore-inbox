Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbUAOVci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUAOVci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:32:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:55275 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263523AbUAOVch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:32:37 -0500
Date: Thu, 15 Jan 2004 13:32:07 -0800
From: Greg KH <greg@kroah.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs class support for OSS sound devices [07/10]
Message-ID: <20040115213207.GG22433@kroah.com>
References: <20040115204048.GA22199@kroah.com> <20040115204111.GB22199@kroah.com> <20040115204125.GC22199@kroah.com> <20040115204138.GD22199@kroah.com> <20040115204153.GE22199@kroah.com> <20040115204209.GF22199@kroah.com> <20040115204241.GG22199@kroah.com> <20040115204259.GH22199@kroah.com> <400704C5.2080309@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400704C5.2080309@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 10:23:17PM +0100, Prakash K. Cheemplavam wrote:
> Greg KH wrote:
> >This patch adds support for all OSS sound devices.
> 
> Please excuse my ignorance, but shouldn't these patches be sent to alsa? 

Heh, you want me to send the OSS patch to the ALSA group?

> I mean unless they are in their cvs, updateing alsa drivers will become 
> a hard task.

They can handle merging these patches properly, and have told me this in
the past.  As the ALSA patches require the class_simple patch, it
wouldn't do me any good to send it to them yet, as it wouldn't even
build for them.

In short, don't worry about it :)

thanks,

greg k-h
