Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266350AbUANO4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUANO4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:56:14 -0500
Received: from mx1.mail.ru ([194.67.23.21]:40205 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S266350AbUANO4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:56:11 -0500
Message-ID: <40055888.4060907@mail.ru>
Date: Wed, 14 Jan 2004 09:56:08 -0500
From: Yaroslav Klyukin <skintwin@mail.ru>
User-Agent: Mozilla/5.0 (ICQ: 1045670, AIM: infiniteparticle)
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMP versus UP on P4
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everybody!

I have this question, which I would like to ask you guys.
I know that SMP works slower, because of thread contention and locking 
mechanisms.

Does it make sence to use SMP kernel still, in case of a single P4,
or should I use UP kernel and disable Hyper-Threading in the bios?

Any benchmark results would be highly appreciated.

Thank you.



