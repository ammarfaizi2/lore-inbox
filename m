Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUAGXg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUAGXg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:36:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:25305 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263125AbUAGXg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:36:56 -0500
Date: Wed, 7 Jan 2004 15:34:26 -0800
From: Greg KH <greg@kroah.com>
To: Richard Troth <rtroth@bmc.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107233426.GC2807@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <Pine.LNX.4.58.0401071123490.12602@home.osdl.org> <20040107195032.GB823@kroah.com> <Pine.LNX.4.53.0401071418300.7097@rmt-desk.bmc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0401071418300.7097@rmt-desk.bmc.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 02:25:44PM -0600, Richard Troth wrote:
> Consider the long-range ramifications
> if a device can also be a directory,  just "magically".
> I'm not going to automatically diss the idea  (other than my
> natural reaction above)  but please consider beyond the immediate hack.

What do you consider the "long-range" ramifications of this change?

Curious,

greg k-h
