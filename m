Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSDQQZM>; Wed, 17 Apr 2002 12:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSDQQZM>; Wed, 17 Apr 2002 12:25:12 -0400
Received: from zebra.siol.net ([193.189.160.16]:59589 "EHLO zebra.siol.net")
	by vger.kernel.org with ESMTP id <S292588AbSDQQZL>;
	Wed, 17 Apr 2002 12:25:11 -0400
Message-Id: <5.1.0.14.2.20020417181853.00bf1c00@212.118.71.191>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Apr 2002 18:24:53 +0200
To: linux-kernel@vger.kernel.org
From: Domen Stangar <domen.stangar@siol.net>
Subject: how to setup loopback before calling mount_root() ..
  root=/dev/loop0
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone please tell me if there is a way to use lo_ioctl before mounting 
root.
How to use lo_ioctl in kernel in way like:
losetup /dev/loop0 /dev/hda3 ?
then root=/dev/loop0

