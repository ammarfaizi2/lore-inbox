Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTIASYF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbTIASYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:24:05 -0400
Received: from mta03.fuse.net ([216.68.1.123]:64418 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id S263572AbTIASYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:24:00 -0400
From: "Dale E Martin" <dmartin@cliftonlabs.com>
Date: Mon, 1 Sep 2003 14:23:59 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4 (more details)
Message-ID: <20030901182359.GA871@cliftonlabs.com>
References: <20030901153305.GA1429@cliftonlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901153305.GA1429@cliftonlabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just removed TCQ from my IDE setup, and I still lock up during boot.  The
last message displayed is:
mice: PS/2 mouse device common for all mice

The numlock comes on, and then I'm locked up hard, for instance, I cannot
turn off the numlock at this point.

One thing that I would note is that I don't have anything plugged into my
PS2/2 port since I have a USB mouse.  (A Kensington Model# MOSUU B, that
works fine in 2.4.x, FWIW.)  Please advise if there is more debugging that
I can try.

Thanks,
	Dale
-- 
Dale E. Martin, Clifton Labs, Inc.
Senior Computer Engineer
dmartin@cliftonlabs.com
http://www.cliftonlabs.com
pgp key available
