Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbTFWSJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbTFWSJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:09:54 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45001 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266085AbTFWSJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:09:54 -0400
Date: Mon, 23 Jun 2003 11:23:54 -0700
From: Greg KH <greg@kroah.com>
To: Lesley van Zijl <zyl@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb memory pen broken since 2.5.72?
Message-ID: <20030623182354.GA10089@kroah.com>
References: <200306231803.42338.zyl@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306231803.42338.zyl@xs4all.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 06:03:42PM +0000, Lesley van Zijl wrote:
> My USB memory pen stopped working since 2.5.72, the last time it
> worked for me was 2.5.70.
> 
> dmesg output on plugin for 2.5.72/73:

Hopefully this is fixed in 2.5.73-bk1 (whenever it shows up.)  Can you
test that?  If not, can you create a bug in bugzilla.kernel.org for
this?

thanks,

greg k-h
