Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSEALmV>; Wed, 1 May 2002 07:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSEALmU>; Wed, 1 May 2002 07:42:20 -0400
Received: from relay1.soft.net ([164.164.128.17]:12236 "EHLO cyclops.soft.net")
	by vger.kernel.org with ESMTP id <S310769AbSEALmT>;
	Wed, 1 May 2002 07:42:19 -0400
Message-ID: <91A7E7FABAF3D511824900B0D0F95D1013704C@BHISHMA>
From: Abdij Bhat <Abdij.Bhat@kshema.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Abdij Bhat <Abdij.Bhat@kshema.com>
Subject: Where is the inetd.conf?
Date: Wed, 1 May 2002 17:11:53 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I no longer find the inetd.conf in either /etc or /etc/inet/. In fact i do
not find in on my whole linux box.
 I am using Red Hat Distribution of Linux Kernel 2.4.7-10. I beleive it is
using xinetd instead of inetd.
 Does this have something to do with the way Linux is loaded on to the
system? (My IT depratment does it for me :( I am not authorized! ).
 I need to install and run tcp wrappers which demand inetd.conf. How can i
circumvent the problem?

Thanks and Regards,
Abdij
