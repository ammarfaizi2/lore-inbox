Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbRGBJab>; Mon, 2 Jul 2001 05:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbRGBJaV>; Mon, 2 Jul 2001 05:30:21 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:24970 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262076AbRGBJaI>; Mon, 2 Jul 2001 05:30:08 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 2 Jul 2001 02:29:55 -0700
Message-Id: <200107020929.CAA02739@adam.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, rhw@MemAlpha.CX,
        rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

	Copping out with "not my job" and then demanding essentially a
mathematical proof of correctness is unpersuasive, but I have no
objection to your change (some select "define_bool xxx no" lines in
a common file that every architecture reads), as long as we have
established that it seems to get along with "make xconfig" after all.
If that is the case, then I'd be just as happy that Linus apply your patch.

	So, with that lame endorsement and nobody else still objecting
to your patch (right?), how about if you submit your patch to Linus,
or is there some other way you want to proceed?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
