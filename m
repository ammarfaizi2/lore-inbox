Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbSKZIO7>; Tue, 26 Nov 2002 03:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSKZIO7>; Tue, 26 Nov 2002 03:14:59 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:59914 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S266296AbSKZIO6>; Tue, 26 Nov 2002 03:14:58 -0500
Date: Tue, 26 Nov 2002 19:21:00 +1100
From: john slee <indigoid@higherplane.net>
To: Dennis Grant <trog@wincom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe
Message-ID: <20021126082059.GB7915@higherplane.net>
References: <3de26215.842.0@wincom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de26215.842.0@wincom.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 12:33:18PM -0500, Dennis Grant wrote:
[ snip long bits ]

a while back giacomo catenazzi (probably spelled wrong) hacked up some
goodies to autodetect what hardware driver options are appropriate for
your system, based on contents of various bits of /proc.  i haven't
heard anything about it in quite some time but it sure seems like this
would be the most appropriate tool for cases like yours.

i believe it generated a baseline .config with appropriate things
enabled; having done that you then went through menuconfig enabling
other things you wanted, like filesystems, non-autodetect-able hardware,
etc.

j.

-- 
toyota power: http://indigoid.net/
