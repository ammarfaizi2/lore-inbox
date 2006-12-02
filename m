Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163002AbWLBNzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163002AbWLBNzT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 08:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163008AbWLBNzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 08:55:18 -0500
Received: from mx0.towertech.it ([213.215.222.73]:3755 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1163002AbWLBNzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 08:55:17 -0500
Date: Sat, 2 Dec 2006 14:55:12 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>,
       eibach@gdsys.de, stieler@gdsys.de, Jean Delvare <khali@linux-fr.org>,
       James Chapman <jchapman@katalix.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       David Brownell <david-b@pacbell.net>
Subject: rtc-ds1307 driver
Message-ID: <20061202145512.3baccf92@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Hello,

  given the recent patch for ds1337 initialization (drivers/i2c/chips),
 I would like to ask owners of DS1307, DS1337, DS1338, DS1339, DS1340, ST M41T00
 to give a try the rtc-ds1307 driver (drivers/rtc).

  I need to be sure that it works (and correctly initializes)
 all the chips that claims to support.

  Jean would be very happy if we can remove drivers from
 i2c/chips ;)
-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

