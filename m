Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTIXVrQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 17:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbTIXVrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 17:47:15 -0400
Received: from h139-142-214-162.gtcust.grouptelecom.net ([139.142.214.162]:19980
	"EHLO smtp.atrium.ca") by vger.kernel.org with ESMTP
	id S261580AbTIXVrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 17:47:15 -0400
Message-id: <fc.008695730061456b008695730061456b.6145b2@atrium.ca>
Date: Wed, 24 Sep 2003 16:49:29 -0500
Subject: 2.6.0-test5-mm3 Promise SuperTrak SX6000 unrecognized
X-FC-Form-ID: 141
To: linux-kernel@vger.kernel.org
From: "Dave Poirier" <dave.poirier@atrium.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Promise SuperTRAK SX6000 IDE RAID controller card which, no
matter which options are set in the kernel, fail to be recognized.  I
tried with 2.4.22, 2.6.0-test1..test5 and 2.6.0-test5-mm3, all of which
simply seems to ignore the card altogether.

Find attached the `lspci -vxx` output.

Let me know if you need any testing, I am more than willing to help on
this.


