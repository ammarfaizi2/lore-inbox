Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUBTAfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUBTAda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:33:30 -0500
Received: from mail.shareable.org ([81.29.64.88]:29056 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267602AbUBTAUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:20:39 -0500
Date: Fri, 20 Feb 2004 00:20:34 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: thockin@sun.com, Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: sysconf - exposing constants to userspace
Message-ID: <20040220002034.GC5590@mail.shareable.org>
References: <20040219204820.GC9155@sun.com> <200402191630.47047.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402191630.47047.jeffpc@optonline.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Sipek wrote:
> I think that making something in /sys would make the most sense,
> with one constant per file. We could dump the consts files to for
> example /sys/consts, or make a logical directory structure to make
> navigation easier.

Isn't that very similar to the /proc/sys/kernel we have now?

-- Jamie
