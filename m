Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWIMA1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWIMA1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWIMA1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:27:09 -0400
Received: from zeus.pimb.org ([80.68.88.21]:28435 "EHLO zeus.pimb.org")
	by vger.kernel.org with ESMTP id S1030435AbWIMA1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:27:08 -0400
Date: Wed, 13 Sep 2006 01:42:22 +0100
From: Jody Belka <lists-lkml@pimb.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060913004222.GD6294@pimb.org>
References: <20060912150433.GB2808@pimb.org> <20060912223309.GA9271@suse.de> <20060912231117.GC2808@pimb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912231117.GC2808@pimb.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 12:11:17AM +0100, Jody Belka wrote:
> On Tue, Sep 12, 2006 at 03:33:09PM -0700, Greg KH wrote:
> > Yes, this exposed a bug in HAL where it was overflowing an internal
> > buffer.  Please upgrade to the latest version, it has been fixed for a
> > few months now.
> 
> Would you happen to have a patch for the fix please? Then i can open a
> report in the ubuntu bug tracker, and they can release an updated 0.5.3
> that will work with 2.6.18.
> 
> Thanks in advance.

Never mind, following some googling i found the commit. Tested and it works,
so opened a bug report with Ubuntu. In the meantime i'm running my own build
of the .deb :)

Thanks for the help.


J
-- 
Jody Belka
knew (at) pimb (dot) org

ps. Please CC me, as i'm not subscribed to the list. Thanks.

