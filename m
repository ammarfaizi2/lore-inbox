Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVLBVsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVLBVsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVLBVsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:48:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:32676 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750812AbVLBVsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:48:32 -0500
Date: Fri, 2 Dec 2005 13:46:55 -0800
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>, rajesh.shah@intel.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [2.6.15-rc4] oops in acpiphp
Message-ID: <20051202214655.GA13599@suse.de>
References: <4390B646.60709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4390B646.60709@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 04:01:58PM -0500, Jeff Garzik wrote:
> 
> Booting with acpiphp on this dual core, dual package (2x2) box causes an 
> oops.

Ok, I've heard about this one before, in looking closer at this.  Rajesh
is aware of this one (right Rajesh?  I'll bounce you the original
message).  I'll let him take it from here...

thanks,

greg k-h
