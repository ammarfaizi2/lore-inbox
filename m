Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131645AbRCSWBS>; Mon, 19 Mar 2001 17:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRCSWBI>; Mon, 19 Mar 2001 17:01:08 -0500
Received: from tallinn.sydamekirurgia.ee ([193.40.6.9]:63760 "EHLO
	ns.linking.ee") by vger.kernel.org with ESMTP id <S131642AbRCSWAz>;
	Mon, 19 Mar 2001 17:00:55 -0500
Date: Tue, 20 Mar 2001 00:00:00 +0200 (GMT-2)
From: Elmer Joandi <elmer@linking.ee>
To: linux-kernel@vger.kernel.org
Subject: atyfb,matrox hardlocks, multihead, USB broken, 2.4.2-ac8
Message-ID: <Pine.LNX.4.21.0103192335590.28735-100000@ns.linking.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.2-ac8, with 4 graphics cards, Dual Celeron
now with 2.4.2-ac8 it is even more clear 
any attempt to insert  module ends with straight lockup
video mode swithc occurs and then ping to the box stops 
immediately.
more, starting X locks kernel the same way.

meantime I changed from BIOS the AGP to be primary video.
this was probably what made the most of difference as 
AGP is with largest PCI ID.

USB is also nonworking. 2.4.0 was  most part OK.


