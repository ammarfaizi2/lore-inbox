Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281383AbRKLMx6>; Mon, 12 Nov 2001 07:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281449AbRKLMxs>; Mon, 12 Nov 2001 07:53:48 -0500
Received: from samar.sasken.com ([164.164.56.2]:1499 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S281383AbRKLMxf>;
	Mon, 12 Nov 2001 07:53:35 -0500
From: Sureshkumar Kamalanathan <skk@sasken.com>
Subject: how do we block interrupts?
Date: Mon, 12 Nov 2001 18:23:29 +0530
Organization: Sasken Communication Technologies Limited
Message-ID: <3BEFC649.313D32AF@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-z.sasken.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
  I have added a function inside kernel in netif_rx().  I want to block
all the ethernet interrupts till this function is executed.  
  How do we block and unblock the interrupts?
  Thanks in advance,

Regards,
Sureshkumar K.
