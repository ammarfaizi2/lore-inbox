Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWATQlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWATQlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWATQlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:41:15 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59111 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751079AbWATQlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:41:14 -0500
Date: Fri, 20 Jan 2006 17:41:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Loftis <mloftis@wgops.com>
cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
In-Reply-To: <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
Message-ID: <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <20060120155919.GA5873@stiffy.osknowledge.org>
 <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Lots of things still out there depend on devfs.  So now if I want to develop my
> kmod on recent kernels I have to be in the business of maintaining a lot more
> userland stuff, like mkinitrd, installers, etc. that have come to rely on
> devfs.

Just like the OSS-ALSA/e100 debate: If there IS something that you 
do not like [something that requires devfs], why has NO ONE objected? 
(Quoting Greg: "and I have not heard a single peep out of anyone about the 
email titled "Subject: devfs going away, last chance to complain"") Not to 
forget there is ndevfs if you really need it.


Jan Engelhardt
-- 
