Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbTIYSwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbTIYSvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:51:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:6106 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261850AbTIYSvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:51:39 -0400
Date: Thu, 25 Sep 2003 11:35:59 -0700
From: Greg KH <greg@kroah.com>
To: David van Hoose <david.vanhoose@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4] USB is broken
Message-ID: <20030925183559.GA29088@kroah.com>
References: <3F73062A.9010807@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F73062A.9010807@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:13:46AM -0400, David van Hoose wrote:
> I compiled and booted 2.4.23-pre5 this morning, and my USB doesn't work. 
>  The devices I have are a HP psc2110xi and a Logitech Cordless Optical 
> Mouse (Logitech Click! Plus).
> My USB does work under 2.4.23-pre4.

As there were no usb changes from -pre4 to -pre5 I think this is an ACPI
issue.  You might want to ask those developers on the acpi-devel mailing
list.

Good luck,

greg k-h
