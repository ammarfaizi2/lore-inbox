Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVHCDLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVHCDLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 23:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVHCDLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 23:11:31 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:37264 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S261902AbVHCDLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 23:11:30 -0400
Date: Wed, 3 Aug 2005 05:11:28 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: nForce2 box doesnt turn off with 2.6.13-rc5
Message-ID: <Pine.LNX.4.60.0508030424590.7376@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my box with nForce2 doesn't turn off automatically with 2.6.13-rc5 
(perhaps also with -rc4). Everything seems to go as it should (both with 
"poweroff" and <Ctrl><SysRq><O>) (even disks park) except for the actual 
turn-off.

With -rc3 it works fine.

Martin

P.S.: It's a Gigabyte 7NNXP with latest BIOS.
