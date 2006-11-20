Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933799AbWKTANS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933799AbWKTANS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 19:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933801AbWKTANS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 19:13:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:22153 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933799AbWKTANR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 19:13:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=I/YzYEuifgvvVcvTM01/yzqp0CC75kOIHPLLVMUVu9uGXHZHdnP7MN/YK5CbBw6ry8o2204usC1K0e/RsND+ekQ4p7tCUYqRQGcCpJE8DW7as7TI2/82U7VSMHqjF9QvM5tOewQ0t3X3t0OsL8VZGPoZGxw8I1heFaGlq2xB1Tw=
Date: Mon, 20 Nov 2006 02:13:14 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <664994303.20061120021314@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
CC: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re[2]: Where did find_bus() go in 2.6.18?
In-Reply-To: <4560ECAF.1030901@gmail.com>
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiri,

Monday, November 20, 2006, 1:45:51 AM, you wrote:

> Paul Sokolovsky wrote:
>>   But alas, the commit message is not as good as some others are, and
>> doesn't mention what should be used instead. So, if find_bus() is
>> "unused", what should be used instead?

> You should probably mention what for?

  Indeed, I'm sorry! Looking at find_bus()'s docstring:

/**
 *      find_bus - locate bus by name.
 *      @name:  name of bus.

 So well, I'd like to know exactly that - what function should be
used instead of find_bus() to locate bus by name.


> regards,



-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com

