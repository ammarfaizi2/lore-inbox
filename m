Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVDHWHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVDHWHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVDHWHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:07:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:47785 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261161AbVDHWHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:07:30 -0400
Date: Fri, 8 Apr 2005 15:05:40 -0700
From: Greg KH <greg@kroah.com>
To: Johannes Stezenbach <js@linuxtv.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Cc: stable@kernel.org
Subject: Re: [PATCH] [fix Bug 4395] modprobe bttv freezes the computer
Message-ID: <20050408220539.GA3399@kroah.com>
References: <20050405145552.GA11360@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405145552.GA11360@linuxtv.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 04:55:52PM +0200, Johannes Stezenbach wrote:
> Here's a patch that fixes
> http://bugme.osdl.org/show_bug.cgi?id=4395.
> 
> In case there's a 2.6.11.7 before 2.6.12 is released it would
> be nice to include this patch there, too.

Thanks, I've added this to the stable queue.

greg k-h
