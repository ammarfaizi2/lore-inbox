Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271749AbTHDOUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271750AbTHDOUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:20:03 -0400
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:13582 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id S271749AbTHDOUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:20:00 -0400
Date: Mon, 4 Aug 2003 15:19:59 +0100 (BST)
From: David McBride <dwm99@doc.ic.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Status of ICH5-R SATA RAID support?
Message-ID: <Pine.LNX.4.50.0308041446580.17591-100000@texel27.doc.ic.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

Intel's ICH5-R chipset, as found on their D875PBZ motherboard, supports
RAID-striping of SATA disks.

I've scoured the list archives and can't find any mention, for or
against, for support of this feature -- Jeff Garzik's libata patchkit,
although significant, doesn't appear to provide striping support.

Am I correct in thinking that there isn't any working striping support
at the moment -- and if so, is anyone working on an implementation?
If not, it might be fun to try and write support for it myself..

Cheers,

David
-- 
David McBride <dwm99@doc.ic.ac.uk>
Department of Computing, Imperial College, London
http://www.doc.ic.ac.uk/~dwm99/

"Much of the excitement we get out of our work is that we don't really
know what we are doing."
	-- Dijkstra
