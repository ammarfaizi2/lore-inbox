Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVKFUey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVKFUey (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 15:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVKFUey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 15:34:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:20947 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751208AbVKFUex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 15:34:53 -0500
Date: Sun, 6 Nov 2005 12:34:21 -0800
From: Greg KH <greg@kroah.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051106203421.GB2527@kroah.com>
References: <E1EYdMs-0001hI-3F@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EYdMs-0001hI-3F@think.thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 12:47:02AM -0500, Theodore Ts'o wrote:
> +P: /class/input/input3/event3

No, this shows a post-2.6.14 kernel, not 2.6.14 as what is located on
kernel.org, right?  I'm guessing 2.6.14-git1?  Or is this a distro based
kernel?

If so, you need to upgrade udev, as the Documentation says to :)

If not, and this is 2.6.14, something is very wrong...

thanks,

greg k-h
