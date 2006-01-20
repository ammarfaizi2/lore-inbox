Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWATRG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWATRG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWATRG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:06:57 -0500
Received: from free.wgops.com ([69.51.116.66]:46608 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1750867AbWATRG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:06:56 -0500
Date: Fri, 20 Jan 2006 10:06:50 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <0B1B67D811A178FB3BE70C96@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <20060120163551.GC5873@stiffy.osknowledge.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <20060120155919.GA5873@stiffy.osknowledge.org>
 <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
 <20060120163551.GC5873@stiffy.osknowledge.org>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 5:35:51 PM +0100 Marc Koschewski 
<marc@osknowledge.org> wrote:

> Moreover, as far as I remember... my devfsd -> udev transsition went as
> smooth as a reboot.

The one machine I've got running 2.6+devfs under debian chokes in initrd 
with an inability to find devfs during boot so I had to go back to static 
/dev entries for it since atleast in sarge right now I'm not seeing a 
quick-and-easy way to get devfs like support bundled via mkinitrd, but I 
haven't looked, and I shouldn't have to.  It shouldn't have gone away in a 
stable kernel in teh first place.  I realise things are changing, and need 
to change but that's called development, and belongs in a development tree.

>
> Marc
>



--
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
