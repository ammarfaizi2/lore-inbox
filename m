Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbRGDXau>; Wed, 4 Jul 2001 19:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266144AbRGDXak>; Wed, 4 Jul 2001 19:30:40 -0400
Received: from sncgw.nai.com ([161.69.248.229]:6275 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S266135AbRGDXaa>;
	Wed, 4 Jul 2001 19:30:30 -0400
Message-ID: <XFMail.20010704163351.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Wed, 04 Jul 2001 16:33:51 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: linux-kernel@vger.kernel.org
Subject: about include/linux/macros.h ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What about the creation of such file containing useful macros like min(),
max(), abs(), etc.. that otherwise everyone is forced to define like :

#ifndef ...
#define ...
#endif




- Davide

