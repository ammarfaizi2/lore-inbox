Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbTLIPLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbTLIPLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:11:55 -0500
Received: from mx2.mail.ru ([194.67.23.22]:3342 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S265951AbTLIPLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:11:53 -0500
Message-ID: <3FD5E636.3030509@mail.ru>
Date: Tue, 09 Dec 2003 10:11:50 -0500
From: Yaroslav Klyukin <skintwin@mail.ru>
User-Agent: Mozilla/5.0 (ICQ: 1045670, AIM: infiniteparticle)
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: HyperThreading with 2.4.23 and Dual Intel Xenon
References: <10wUb-1mR-37@gated-at.bofh.it> <10xGt-38t-29@gated-at.bofh.it>
In-Reply-To: <10xGt-38t-29@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>>we compiled 2.4.23 for 2 cpus but we don't get Hyperthreading working.
>>with 2.4.20 and the machine, it work without probs.
>>
>>Any ideas? 

Maybe you need to enable ACPI.

