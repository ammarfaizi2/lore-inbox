Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRB1SGV>; Wed, 28 Feb 2001 13:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRB1SF5>; Wed, 28 Feb 2001 13:05:57 -0500
Received: from mill.gdls.com ([4.18.140.69]:61139 "EHLO mill.gdls.com")
	by vger.kernel.org with ESMTP id <S129134AbRB1SF0>;
	Wed, 28 Feb 2001 13:05:26 -0500
From: "Keven Murphy" <murphyk@gdls.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.2 & PPP bad file descriptor
Date: Wed, 28 Feb 2001 13:06:14 -0500
Message-ID: <NEBBJIOMKDAKJOCGELHHEEGBCLAA.murphyk@gdls.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <A490B2C9C629944E85CE1F394138AF957FC3EA@bignorse.SURGIENT.COM>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recompiled my kernel to 2.4.2 (even tried 2.4.1) and I am having
problems with pppd. The error I am getting is pppd[1491]: read: bad file
descriptor (9). Under the kernel 2.2.22-16 (or whatever came default with
redhat 7.0) it work fine. I am using a default redhat 7.0 install.

I have tried compiling the ppp and options as modules and another time into
the kernel. I keep getting the same results. I have also downloaded and
installed the latest version of modutilities after getting the error. I
recompiled again and recieved the same error.

If for some reason this is not the right list, please tell me where I can go
to get help with this problem.

Thank you for any help,

Xavier
xavier@greyhawk-codex.com


