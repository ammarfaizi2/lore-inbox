Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSJPJPN>; Wed, 16 Oct 2002 05:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264985AbSJPJPN>; Wed, 16 Oct 2002 05:15:13 -0400
Received: from viefep16-int.chello.at ([213.46.255.17]:1077 "EHLO
	viefep16-int.chello.at") by vger.kernel.org with ESMTP
	id <S264983AbSJPJPM>; Wed, 16 Oct 2002 05:15:12 -0400
Subject: usb CF reader and 2.4.19
From: Joseph Wenninger <jowenn@kde.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Oct 2002 11:22:04 +0200
Message-Id: <1034760128.1306.4.camel@jowennmobile>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Is there anything I can do to flush all usb / usb storage buffers to my
compact flash ? 

At the moment I have to rmmod usb-storage && rmmod usb-uhci && modprobe
usb-uhci && modprobe usb-storage to ensure all data is written
correctly, otherwise the directory structure isn't saved even after an
unmount.

Is there an application, function call, ioctl, .... which I can use,
instead of the above mentioned inconvenient way ?

Kind regards
Joseph Wenninger



