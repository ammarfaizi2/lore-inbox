Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWILWz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWILWz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWILWz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:55:59 -0400
Received: from zeus.pimb.org ([80.68.88.21]:22035 "EHLO zeus.pimb.org")
	by vger.kernel.org with ESMTP id S932339AbWILWz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:55:58 -0400
Date: Wed, 13 Sep 2006 00:11:17 +0100
From: Jody Belka <lists-lkml@pimb.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060912231117.GC2808@pimb.org>
References: <20060912150433.GB2808@pimb.org> <20060912223309.GA9271@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912223309.GA9271@suse.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 03:33:09PM -0700, Greg KH wrote:
> Yes, this exposed a bug in HAL where it was overflowing an internal
> buffer.  Please upgrade to the latest version, it has been fixed for a
> few months now.

Would you happen to have a patch for the fix please? Then i can open a
report in the ubuntu bug tracker, and they can release an updated 0.5.3
that will work with 2.6.18.

Thanks in advance.


J
-- 
Jody Belka
knew (at) pimb (dot) org

ps. Please CC me, as i'm not subscribed to the list. Thanks.
