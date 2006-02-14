Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbWBNSrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbWBNSrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWBNSrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:47:10 -0500
Received: from jose.lug.udel.edu ([128.175.60.112]:953 "EHLO jose.lug.udel.edu")
	by vger.kernel.org with ESMTP id S1030476AbWBNSrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:47:08 -0500
Date: Tue, 14 Feb 2006 13:47:08 -0500
To: Marc Koschewski <marc@osknowledge.org>
Cc: Christian <christiand59@web.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
Message-ID: <20060214184708.GA29656@lug.udel.edu>
References: <20060214135016.GC10701@stusta.de> <200602141659.40176.christiand59@web.de> <20060214164002.GC5905@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214164002.GC5905@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11
From: ross@jose.lug.udel.edu (Ross Vandegrift)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 05:40:03PM +0100, Marc Koschewski wrote:
> Is that maybe dependant on _what_ version of Samba is running on the receiving
> end?

I've seen it copying to Windows 2k3.  Only uploading large files, and
it's not every time.  I'd say 50% of the time, my box freezes when
copying something around 100MiB or larger.

IIRC, my workstation at the office is running 2.6.15.1 or .4.

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
