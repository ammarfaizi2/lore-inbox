Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270098AbTGMEOg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 00:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270094AbTGMENQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 00:13:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:18646 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270096AbTGMENI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 00:13:08 -0400
Date: Sat, 12 Jul 2003 21:15:57 -0700
From: Greg KH <greg@kroah.com>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <20030713041557.GC2695@kroah.com>
References: <1056755336.5459.16.camel@dhcp22.swansea.linux.org.uk> <20030627.172123.78713883.davem@redhat.com> <1056827972.6295.28.camel@dhcp22.swansea.linux.org.uk> <20030628.150328.74739742.davem@redhat.com> <m2vfu765cx.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2vfu765cx.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 10:07:42AM -0700, Jan Rychter wrote:
> It hasn't. The result is a system that works for you (and other active
> developers), but not for everyone. As an example -- try running Linux on
> a modern laptop, connecting some USB devices, using ACPI, or
> bluetooth. Observe the resulting problems and crashes. You'll hit loads
> of obscure bugs that have been reported, but never got looked at in
> detail. I certainly have hit them and reported most, and most got
> dropped in various places.

What USB bugs have you reported that have gotten dropped?

Note, a _lot_ of USB bluetooth devices are real flaky, not much the
kernel can do about them :(

greg k-h
