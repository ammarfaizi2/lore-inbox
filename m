Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUDXPza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUDXPza (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 11:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUDXPza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 11:55:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:39138 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262388AbUDXPz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 11:55:29 -0400
Date: Sat, 24 Apr 2004 08:55:07 -0700
From: Greg KH <greg@kroah.com>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and /dev/sda1 not found during boot (it's there right after boot)
Message-ID: <20040424155507.GA11273@kroah.com>
References: <408A1945.1030506@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408A1945.1030506@bigfoot.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2004 at 12:37:41AM -0700, Erik Steffl wrote:
>   just moved to udev and everything seems to be working OK except of 
> SATA drive (visible as /dev/sda1) when fsck checks it during boot (it 
> works fine right after that).

This is a Debian specific bug/issue.  I suggest you file it against the
Debian udev package, as it is not a kernel issue.

thanks,

greg k-h
