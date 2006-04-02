Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWDBSSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWDBSSW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 14:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWDBSSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 14:18:22 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:52707 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750779AbWDBSSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 14:18:22 -0400
Date: Sun, 02 Apr 2006 13:18:16 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Firewire problems, apparently since 2.6.13-rc1
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Reply-to: gene.heskett@verizononline.net
Message-id: <200604021418.16263.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

How much trouble will I have if I take the current 2.6.16.1 kernel src 
tree, nuke the ieee1394 directory of it, and bring the ieee1394 
directory in from the 2.6.12 tarball?

At 2.6.12, all the firewire stuff I needed to import from my camera, 
edit it, and make vcd's or dvd's out of it worked _flawlessly_.  Now, 
at 2.6.16.1, and apparently since 2.6.13-rc1, kino is broken and must 
be killed by the system when it hangs.  I figured it would get sorted, 
but apparently not.

I can recover from backups all the stuff I've overwritten in the last 2 
days trying to make it work.  That should make it all work again IF the 
ieee1394 stuff was reverted to the 2.6.12 version.  Is this feasable at 
all?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
