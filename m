Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbUDGSOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbUDGSOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:14:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:16010 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264056AbUDGSNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:13:47 -0400
Date: Wed, 7 Apr 2004 11:10:15 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB/BlueTooth oops in 2.6.5
Message-ID: <20040407181015.GA20173@kroah.com>
References: <877jwse1pl.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877jwse1pl.fsf@enki.rimspace.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 04:33:58PM +1000, Daniel Pittman wrote:
> When I try to turn on the BlueTooth interface in my laptop, it turns on
> a USB device.  Doing that with 2.6.5 generates the following error.

It's being worked on:

	http://bugme.osdl.org/show_bug.cgi?id=2423

thanks,

greg k-h
