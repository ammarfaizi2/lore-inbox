Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTKYBP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 20:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTKYBP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 20:15:26 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:58565 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261764AbTKYBP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 20:15:26 -0500
Subject: kernel BUG at raid5.c:337!
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: oliver@neukum.name, aliakc@web.de, lenehan@twibble.org, mingo@redhat.com,
       neilb@cse.unsw.edu.au
Content-Type: text/plain
Organization: 
Message-Id: <1069721971.723.408.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Nov 2003 19:59:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a picture of a crash on a kiosk or something, as
a Linux example in Slashdot's public BSOD sightings...

http://w3.physics.uiuc.edu/~menscher/tekram1.jpg

So... unknown kernel version, but there's a
line number that ought to narrow things down.

Can anybody help this guy?  :-)


