Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266133AbRGDS6l>; Wed, 4 Jul 2001 14:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbRGDS6b>; Wed, 4 Jul 2001 14:58:31 -0400
Received: from sncgw.nai.com ([161.69.248.229]:2202 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S266133AbRGDS6U>;
	Wed, 4 Jul 2001 14:58:20 -0400
Message-ID: <XFMail.20010704120139.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Wed, 04 Jul 2001 12:01:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: linux-kernel@vger.kernel.org
Subject: sizes ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For which supported linux architectures this is false :

PAGE_SIZE % (sizeof(int) + 2 * sizeof(short)) == 0




- Davide

