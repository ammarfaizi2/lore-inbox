Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283052AbRLDLGB>; Tue, 4 Dec 2001 06:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283046AbRLDLFs>; Tue, 4 Dec 2001 06:05:48 -0500
Received: from mail-relay.eunet.no ([193.71.71.242]:49417 "EHLO
	mail-relay.eunet.no") by vger.kernel.org with ESMTP
	id <S283059AbRLDLFf>; Tue, 4 Dec 2001 06:05:35 -0500
Subject: 2.4.17-pre2 missing ymfpci updates
From: petter wahlman <pwa@norman.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 12:06:09 +0100
Message-Id: <1007463970.2776.2.camel@lunix>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to the changelog there should be some changes to the
ymfpci driver. This does not seem to be the case:

[97%](petter):patches>egrep -i 'ymf|Zaitcev' patch-2.4.17-pre2
[97%](petter):patches>

from changelog:
...
- ymfpci driver cleanup 			(Pete Zaitcev)
...


btw: I'm not subscribed to this list.


Petter Wahlman

