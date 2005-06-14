Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVFNVHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVFNVHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVFNVHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:07:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:2462 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261335AbVFNVHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:07:39 -0400
Date: Tue, 14 Jun 2005 14:06:27 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: off by one in sysfs
Message-ID: <20050614210627.GB19875@kroah.com>
References: <9e47339105061120007061d7b1@mail.gmail.com> <9e47339105061208417f7097b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105061208417f7097b9@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 11:41:32AM -0400, Jon Smirl wrote:
> Patch to fix the off by one.

Looks good, thanks.

greg k-h
