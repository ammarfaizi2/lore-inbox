Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130085AbRBUFmD>; Wed, 21 Feb 2001 00:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131210AbRBUFly>; Wed, 21 Feb 2001 00:41:54 -0500
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:35571 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S130085AbRBUFll>; Wed, 21 Feb 2001 00:41:41 -0500
Date: Wed, 21 Feb 2001 00:36:34 -0500 (EST)
From: pf-kernel@mirkwood.net
To: linux-kernel@vger.kernel.org
Subject: loopback mount broken in 2.4.2-pre4
Message-ID: <Pine.LNX.4.20.0102210033040.401-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The subject gives just about all the information I have.  :)  If I try to
mount an iso image via loopback while running 2.4.2-pre4, mount will hang
forever.  Downgrading to 2.4.1 seems to resolve the issue (haven't tried
any previous -pre patches).


-----------------------------------
Unsolicited advertisments to this address are not welcome.

