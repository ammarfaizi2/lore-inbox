Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWB1DCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWB1DCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWB1DCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:02:44 -0500
Received: from jose.lug.udel.edu ([128.175.60.112]:188 "EHLO jose.lug.udel.edu")
	by vger.kernel.org with ESMTP id S1751127AbWB1DCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:02:43 -0500
Date: Mon, 27 Feb 2006 22:02:43 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Marc Koschewski <marc@osknowledge.org>, Christian <christiand59@web.de>,
       linux-kernel@vger.kernel.org, sfrench@samba.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
Message-ID: <20060228030243.GA18507@lug.udel.edu>
References: <20060214135016.GC10701@stusta.de> <200602141659.40176.christiand59@web.de> <20060214164002.GC5905@stiffy.osknowledge.org> <20060214184708.GA29656@lug.udel.edu> <20060227062926.GP3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227062926.GP3674@stusta.de>
User-Agent: Mutt/1.5.11
From: ross@jose.lug.udel.edu (Ross Vandegrift)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 07:29:26AM +0100, Adrian Bunk wrote:
> Christian, Ross, my freezes are fixed in 2.6.16-rc5.
> Can you check whether 2.6.16-rc5 also fixes your freezes?

During the last week my workstation at the office was upgraded.  I
haven't been able to reproduce the freeze on the new box after
uploading a few 600MB ISO images.  This certainly would've tripped the
old machine, but this one seems fine.

Similar kernel version, 2.6.15-1-686-smp from Debian etch.  The
possible major difference is that the old box wasn't SMP, the new one
is.

Sorry, not much help!

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
