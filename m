Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUHQMGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUHQMGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268188AbUHQMFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:05:47 -0400
Received: from zeus.kernel.org ([204.152.189.113]:41963 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266486AbUHQMFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:05:34 -0400
Message-ID: <01f501c4844f$ba86dd60$03c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Rusty Russell" <rusty@rustcorp.com.au>, "Tim Bird" <tim.bird@am.sony.com>
Cc: "linux kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
References: <20040817095601.4E7F22BEC3@ozlabs.org>
Subject: Re: [PATCH] - trivial comment fixups in init/main.c
Date: Tue, 17 Aug 2004 07:45:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <40F42C44.5010603@am.sony.com> you write:
>> This patch has some trivial comment fixups for init/main.c, to bring
>> the comments into consistency with the coding style of the kernel.
>
> Personally, I prefer my comments quiet and unobtrusive, and I think
> you'll find Linus' code tends to be the same.
>
> Not to start a flame war, but since I started using a colorizing
> editor for code, I found there was no need to waste vertical space
> with large banners.  (This in my mind justifies the X project's entire
> existence).

Personally, I agree with you. Andrew specifically requested this patch to 
bring a few oddball comments in line with those throughout the rest of the 
file. I'd be happy to go the other way instead.

--Adam


