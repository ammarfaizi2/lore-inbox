Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263964AbTE0QtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 12:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbTE0QtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 12:49:08 -0400
Received: from mail.intrusion.com ([12.148.143.187]:54474 "EHLO
	mail.intrusion.com") by vger.kernel.org with ESMTP id S263964AbTE0QtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 12:49:07 -0400
Message-ID: <636A9B29EA94BC4194D844C27A3B1AAB03FC7D91@mercury.intrusion.com>
From: "Corbett, David" <corbett@intrusion.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: sis900 802.1q VLAN Overlength Packets
Date: Tue, 27 May 2003 12:02:04 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anybody know if the sis900 can be used with 802.1q VLANs, where
the 4 bytes of tag information do not cause the driver to drop
packets with (# of payload bytes) > 1496 ? I've searched the Internet
and archives, but have found no definitive answer. I updated the
sis900 driver from the 2.4.9-34 kernel to the one in the 2.4.20 kernel
but I see no difference. I found information about allowing jumbo
frames, but I am not sure if this is the best approach. 

If I need to ask this question elsewhere, please tell me. 



