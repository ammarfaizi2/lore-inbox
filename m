Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSKHLF2>; Fri, 8 Nov 2002 06:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbSKHLF2>; Fri, 8 Nov 2002 06:05:28 -0500
Received: from 216-99-218-29.dsl.aracnet.com ([216.99.218.29]:16105 "EHLO
	dexter.groveronline.com") by vger.kernel.org with ESMTP
	id <S261839AbSKHLF2>; Fri, 8 Nov 2002 06:05:28 -0500
Message-ID: <3DCB9BD8.4070004@groveronline.com>
Date: Fri, 08 Nov 2002 03:11:20 -0800
From: Andy Grover <andy@groveronline.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andy Grover <agrover@groveronline.com>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
Subject: Re: [PATCH] Make ACPI unselectable in 2.4.20-rc1
References: <Pine.LNX.4.44.0211071811450.3860-100000@dexter.groveronline.com> <20021108092416.GA29848@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>My plan is to start feeding you bits of ACPI changes after 2.4.20 is 
>>released. However, for 2.4.20, I'd like to make sure the really old code 
>>in 2.4.20 doesn't bite any casual kernel builders.

> There are no changes from 2.4.19, so I guess right thing is to leave
> it there. People would loose their configs this way, etc.

Yeah you're right. Sorry, bad idea. Never mind.

-- Andy

