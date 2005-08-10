Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVHJBz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVHJBz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 21:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVHJBz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 21:55:58 -0400
Received: from sc1-24.217.169.229.charter-stl.com ([24.217.169.229]:58092 "EHLO
	ardvarc.coronya.com") by vger.kernel.org with ESMTP
	id S1751040AbVHJBz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 21:55:58 -0400
Message-ID: <42F95E9E.90204@yahoo.com>
Date: Tue, 09 Aug 2005 20:55:42 -0500
From: Salah Coronya <salahx@yahoo.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: I2C block reads with i2c-viapro: testers wanted
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a VT8235 chipset, I applied the patch to my kernel 
(2.6.12-gentoo-r6), comapred the "before" and "after" eeproms in /sys 
with diff and they are the same.

So it seems to work with VT8235.
