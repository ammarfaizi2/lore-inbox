Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272427AbRIFIZz>; Thu, 6 Sep 2001 04:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272431AbRIFIZg>; Thu, 6 Sep 2001 04:25:36 -0400
Received: from gateway.pace.co.uk ([195.44.197.250]:33185 "EHLO
	animal.pace.co.uk") by vger.kernel.org with ESMTP
	id <S272427AbRIFIZ1>; Thu, 6 Sep 2001 04:25:27 -0400
Message-ID: <54045BFDAD47D5118A850002A5095CC30AC57D@exchange1.cam.pace.co.uk>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: User Space Emulation of Devices
Date: Thu, 6 Sep 2001 09:25:08 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without going into the gory details, I have a requirement for a device
driver that does very little apart from pass on the open/close/read/write
"requests" onto a user space application to implement and pass back to the
driver.

Does anything like this already exist?

Thanks,
Phil
