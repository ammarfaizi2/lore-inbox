Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286260AbRLJN1y>; Mon, 10 Dec 2001 08:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbRLJN1n>; Mon, 10 Dec 2001 08:27:43 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:9422 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286260AbRLJN1c>; Mon, 10 Dec 2001 08:27:32 -0500
Date: Mon, 10 Dec 2001 08:25:39 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: linux-kernel@vger.kernel.org
Subject: mm question
Message-ID: <Pine.LNX.4.20.0112100820570.16878-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Things change. In particular Linux since 2.x.x. After spending several
hours peering at prolifiration of functions and constants in mm.h I
decided to take an easy way out and ask people responsible for this
sophistication:

 How does one do the following task: obtain a bunch of free pages (around
300K) with physical addresses between certain bounds (more then
0x4000000, but it is likely this is not constant) reserver them and map to
kernel space so that the driver can access them directly ?

                        thanks !

                               Vladimir Dergachev

