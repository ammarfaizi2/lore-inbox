Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278088AbRJKEWz>; Thu, 11 Oct 2001 00:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278089AbRJKEWf>; Thu, 11 Oct 2001 00:22:35 -0400
Received: from dialup-65-169-128-25.olp.net ([65.169.128.25]:60034 "EHLO
	dialup-65-169-128-25.olp.net") by vger.kernel.org with ESMTP
	id <S278088AbRJKEWe>; Thu, 11 Oct 2001 00:22:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: arvest@orphansonfire.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.11 loses sda9
Date: Wed, 10 Oct 2001 23:22:59 -0500
X-Mailer: KMail [version 1.2]
X-identity: qwertyatorphansonfire
MIME-Version: 1.0
Message-Id: <01101023225900.03884@lithium>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I recompiled (I used the same .10 conf) and rebooted, but my reboot halted 
because /dev/sda9 didnt exist.  I checked this in fdisk, and it didnt see it. 
 I rebooted to the 2.4.10 kernel, and sda9 was there.  What happened?
