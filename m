Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130892AbQKVDw3>; Tue, 21 Nov 2000 22:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131602AbQKVDwK>; Tue, 21 Nov 2000 22:52:10 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:3336 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130892AbQKVDv5>; Tue, 21 Nov 2000 22:51:57 -0500
Message-ID: <3A1B3ADB.17200DF6@timpanogas.org>
Date: Tue, 21 Nov 2000 20:17:47 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: modutils 2.3.20 not backward compatible
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

Was there a reason we removed the -i and -m options from newer modutils
and broke backwards caompatibility?  I'm re-writing our module build
scripts for the installer, and I discovered after upgrading to 2.3.20,
that all the build scripts (about 10MB worth) are now busted and I have
been spending most of this evening rewriting them so they work again.   

Thanks

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
