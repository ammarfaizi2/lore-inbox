Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUE0CKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUE0CKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 22:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUE0CKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 22:10:24 -0400
Received: from v29-39.icu.ac.kr ([210.107.129.39]:694 "EHLO www.ensoltek.co.kr")
	by vger.kernel.org with ESMTP id S261505AbUE0CKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 22:10:23 -0400
Message-ID: <055201c4438f$b5bb1ea0$78816bd2@nso>
From: =?ks_c_5601-1987?B?s6q787/B?= <nso@ensoltek.co.kr>
To: <linux-kernel@vger.kernel.org>
Cc: =?ks_c_5601-1987?B?s6q787/B?= <nso@ensoltek.co.kr>
Subject: mlockall bug in kernel 2.6.6
Date: Thu, 27 May 2004 11:09:57 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Please answer to me too, because I am not subscribed to this list.

I tested linux kernel 2.6.4 with posixtestsuite 1.3.0.
But my system hang up at mlockall/14-1 test.
I tried with kernel 2.6.6 too, but system hangup was occurred.
