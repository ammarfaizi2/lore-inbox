Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVAAQF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVAAQF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 11:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVAAQF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 11:05:57 -0500
Received: from mxsf06.cluster1.charter.net ([209.225.28.206]:64983 "EHLO
	mxsf06.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261154AbVAAQFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 11:05:52 -0500
Message-Id: <3k77vr$fs05t3@mxip08a.cluster1.charter.net>
X-Ironport-AV: i="3.88,96,1102309200"; 
   d="scan'208"; a="532682659:sNHT12888836"
From: "Joseph D. Wagner" <technojoecoolusa@charter.net>
To: <jwendel10@comcast.net>, <mikeserv@bmts.com>, <zaitcev@redhat.com>
Cc: "Fedora Development List" <fedora-devel-list@redhat.com>,
       "Fedora List" <fedora-list@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Newbie" <linux-newbie@vger.kernel.org>
Subject: RE: Kernel 2.6.10 Can't Open Initial Console on FC3
Date: Sat, 1 Jan 2005 10:05:57 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
thread-index: AcTwG8eVWTdgvowuR6OBuM+5B4JroQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RESOLVED.

I enabled support for hotplug devices and installed an initrd; then it works.

They tell me there's a way to make it work without initrd, but it's ugly, messy, and not recommended:

http://fedora.redhat.com/docs/udev/

I haven't yet tested to see if it works with initrd and without support for hotplug devices, but from the documentation I've read my money is on no.

Joseph D. Wagner

