Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbUAGVGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265557AbUAGVGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:06:18 -0500
Received: from mail.kroah.org ([65.200.24.183]:31653 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265576AbUAGVGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:06:15 -0500
Date: Wed, 7 Jan 2004 13:06:11 -0800
From: Greg KH <greg@kroah.com>
To: Michael Stucki <mundaun@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference
Message-ID: <20040107210610.GB1083@kroah.com>
References: <200401011944.51109.lilo.please.no.spam@roccatello.it> <20040102013238.GC19598@kroah.com> <bt632p$26h$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bt632p$26h$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 10:47:05AM +0100, Michael Stucki wrote:
> Dear Greg,
> 
> I have exactly the same problem and I am using nvidia's binary drivers as
> well, so they might be a problem anyway.

Can you duplicate this on 2.6.1-rc2 + the sysfs patch without the nvidia
drivers?

thanks,

greg k-h
