Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVEEPre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVEEPre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVEEPre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:47:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:63377 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262141AbVEEPrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:47:15 -0400
Date: Thu, 5 May 2005 01:22:50 -0700
From: Greg KH <greg@kroah.com>
To: Joe <joecool1029@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Extremely poor umass transfer rates
Message-ID: <20050505082250.GA2594@kroah.com>
References: <3YjKy-72a-21@gated-at.bofh.it> <3YkGD-7NT-15@gated-at.bofh.it> <3Ylt2-8mA-7@gated-at.bofh.it> <3YlWb-px-35@gated-at.bofh.it> <3YCkl-5lB-21@gated-at.bofh.it> <4273E5B3.6040708@shaw.ca> <d4757e6005050420133ecd39c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4757e6005050420133ecd39c6@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 11:13:55PM -0400, Joe wrote:
> Something is definetly going on with either vfat or the USB drivers...
> My ipod is unrunnable on linux now.  To put it plainly, it transfers
> painfully slow (on USB 2.0 mind you), it randomly ceases to respond
> during file transfers.. and will only respond if replugged in.. its
> corrupted my music and the fs to the point where i've now done two
> low-level formats, and every time i put the stuff back on, the same
> problems persist.

Are you using the ub or usb-storage driver?

thanks,

greg k-h
