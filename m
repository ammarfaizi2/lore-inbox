Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVCOJ6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVCOJ6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 04:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVCOJ6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 04:58:48 -0500
Received: from [195.144.244.147] ([195.144.244.147]:27808 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S262363AbVCOJ6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 04:58:46 -0500
Message-ID: <4236B1D1.7030707@varma-el.com>
Date: Tue, 15 Mar 2005 12:58:41 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RFC: CANbus subsytem for 2.6 kernel (char or netdev)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all

I look through code of exist CANbus drivers, and have, may be strange, 
next question:

Anyone could told me, why everyone, who wrote CANbus driver (peak, 
kvaser etc) always use char dev, but not netdev for it? May be exist 
some global pitfall, which I couldn't see, which prevent to use netdev?

-- 
Regards
Andrey Volkov.

