Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275482AbTHNUIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275483AbTHNUIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:08:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:59305 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275482AbTHNUII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:08:08 -0400
Date: Thu, 14 Aug 2003 13:08:17 -0700
From: Greg KH <greg@kroah.com>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Weird behavior of usblp
Message-ID: <20030814200817.GA3156@kroah.com>
References: <20030814195742.GA30804@firesong>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030814195742.GA30804@firesong>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 12:57:42PM -0700, Joshua Kwan wrote:
> Everytime I send a page to my printer connected to my USB hub for the 
> FIRST time on kernel 2.6.0-test3-mm1, this happens:

Patch was posted to linux-usb-devel for this, and it's now in my kernel
tree.  It should show up in Linus's tree in a few days.

thanks,

greg k-h
