Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265703AbSKFPQy>; Wed, 6 Nov 2002 10:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265704AbSKFPQx>; Wed, 6 Nov 2002 10:16:53 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:3846 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265703AbSKFPQx>; Wed, 6 Nov 2002 10:16:53 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB183D@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Manish Lachwani <manish@Zambeel.com>
Subject: Regarding zerocopy implementation ...
Date: Wed, 6 Nov 2002 07:23:20 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a zerocopy receive implementation in Linux? I know that FreeBSD
5.0-CURRENT has such an implementation named zerocopy sockets and when used
with a Alteon Tigon II NIC with header splitting turned on in Firmware,
works well. Do we have any such implementation in Linux? Any reponse is
greatly appreciated ...

Thanks
Manish
