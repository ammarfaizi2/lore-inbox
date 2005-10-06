Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVJFWt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVJFWt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 18:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVJFWt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 18:49:27 -0400
Received: from seqima.han-solo.net ([83.138.65.243]:24525 "EHLO
	seqima.han-solo.net") by vger.kernel.org with ESMTP
	id S1751155AbVJFWt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 18:49:27 -0400
Message-ID: <4345A9F4.7040000@uni-bremen.de>
Date: Fri, 07 Oct 2005 00:49:24 +0200
From: Georg Lippold <lippold@uni-bremen.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hpa@zytor.com
CC: linux-kernel@vger.kernel.org
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com> <20050831215757.GA10804@taniwha.stupidest.org> <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com> <431DFEC3.1070309@zytor.com> <431E00C8.3060606@gmail.com>
In-Reply-To: <431E00C8.3060606@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

what's the status of this? linux-2.6.14-rc3 still has 256 chars limit. A 
quick fix to 1024 would help a lot. Other Platforms have up to 4096...

Greetings,

Georg
