Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbTCELNH>; Wed, 5 Mar 2003 06:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbTCELNH>; Wed, 5 Mar 2003 06:13:07 -0500
Received: from quechua.inka.de ([193.197.184.2]:49796 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S265612AbTCELNG>;
	Wed, 5 Mar 2003 06:13:06 -0500
Subject: ipsec-tools 0.1 + kernel 2.5.64
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: mit_warlord@users.sourceforge.net, HOWTO@ds9a.nl,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1046863752.441.7.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Mar 2003 12:29:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

both manual keying and automatic keying with racoon (pre-shared secret)
are working fine. No need to patch or modify anything. 
I tried only ipv4.

But: don't "setkey -DP" while racoon is running, it crashes
my machine. Sorry, could not get any details.

Andreas

