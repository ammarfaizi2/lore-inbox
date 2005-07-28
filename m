Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVG1Dqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVG1Dqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 23:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVG1Dqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 23:46:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:55237 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261285AbVG1Dql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 23:46:41 -0400
Date: Wed, 27 Jul 2005 20:46:10 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050728034610.GA12123@kroah.com>
References: <9e4733910507250728a7882d4@mail.gmail.com> <d120d5000507250748136a1e71@mail.gmail.com> <9e47339105072509307386818b@mail.gmail.com> <20050726000024.GA23858@kroah.com> <9e473391050725172833617aca@mail.gmail.com> <20050726003018.GA24089@kroah.com> <9e47339105072517561f53b2f9@mail.gmail.com> <20050726015401.GA25015@kroah.com> <9e473391050725201553f3e8be@mail.gmail.com> <9e47339105072719057c833e62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105072719057c833e62@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 10:05:34PM -0400, Jon Smirl wrote:
> Any comments on this? I'll fix up the whitespace issues if everyone
> agrees that the code works.

I'll add the patch to my tree and -mm if you clean up the whitespace
issues :)

thanks,

greg k-h
