Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbUBWJuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUBWJuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:50:55 -0500
Received: from smtpcl1.fiducia.de ([195.200.32.50]:62413 "EHLO
	smtpcl1.fiducia.de") by vger.kernel.org with ESMTP id S261902AbUBWJuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:50:54 -0500
Sensitivity: 
Subject: distinguish two identical network cards
To: linux-kernel@vger.kernel.org
Message-ID: <OF0D5B57F7.B29B3783-ONC1256E43.0035BF41@fiducia.de>
From: andreas.hartmann@fiducia.de
Date: Mon, 23 Feb 2004 10:53:08 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Some clarification:
It is important, that the cards can be distinguished without any user driven
action - it must run automatically. The machines will be delivered to somebody
who doesn't know anything about linux / unix. I must be able to do a
configuration like that:

Physical upper card: eth0
Physical lower card: eth1

The customer will be told, e.g.: plug in the network cable from switch a to the
upper card, the cable to the switch b must be connected to the lower card.



Thank you for every hint,
kind regards,
Andreas Hartmann


