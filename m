Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUIJP4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUIJP4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUIJPw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:52:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:13700 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267507AbUIJPtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:49:02 -0400
Date: Fri, 10 Sep 2004 07:30:32 -0700
From: Greg KH <greg@kroah.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4, visor.c, Badness in usb_unlink_urb
Message-ID: <20040910143032.GC15934@kroah.com>
References: <20040910082601.GA32746@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910082601.GA32746@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 10:26:01AM +0200, Norbert Preining wrote:
> Hi!
> 
> Syncing my PalmOne T|C I get a lot of error messages (see below).
> Suprisingly this didn't disturb my palm to be synced. 

Fixed and will show up in the next -mm released.

thanks,

greg k-h
