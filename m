Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUAOTLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbUAOTLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:11:06 -0500
Received: from a-64-101-biz2.mts.net ([205.200.64.101]:9608 "EHLO opensky.ca")
	by vger.kernel.org with ESMTP id S263015AbUAOTLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:11:04 -0500
Subject: addition to via82xx dxs_support whitelist
From: Jason Hildebrand <jason@peaceworks.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1074193671.3255.101.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 13:07:52 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to report that my via82xx chip requires dxs_support=1 (VIA_DXS_ENABLE) to work without hissing or clicking, so that this info can be added to the 
whitelist.

The audio device is:

00:11.5 Class 0401: 1106:3059 (rev 50)
        Subsystem: 1297:a232

00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device a23

Please cc me if more info is required as I'm not subscribed to this list.

--
Jason D. Hildebrand
jason@peaceworks.ca

