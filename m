Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbUCAIvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUCAIvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:51:09 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:7114 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262284AbUCAIvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:51:07 -0500
Date: Mon, 1 Mar 2004 09:50:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: More s390 patches.
Message-ID: <20040301085053.GA675@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
almost there. The delta between our internal CVS and the BitKeeper is
getting really small. To keep it that way I created another 5 patches
with code that has been checked in by our development team over the
week.

Short descriptions:
1) More s390 architecture fixes.
2) Common i/o layer fixes.
3) Sclp console driver fixes.
4) Add a private tape class to the ccw tape device driver.
5) Replace last old style module parameter in the xpram driver.

There are two bigger things left for integration. The crypto device driver
that is in the last stages of the test and our network guys are doing a
major overhaul of the qeth driver. This new qeth is not working 100% yet
but they are getting there. This is something for > 2.6.[456].

Have a nice weekend & blue skies,
  Martin.

