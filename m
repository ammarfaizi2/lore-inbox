Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbSKZRlL>; Tue, 26 Nov 2002 12:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbSKZRlL>; Tue, 26 Nov 2002 12:41:11 -0500
Received: from mail.wincom.net ([209.216.129.3]:45061 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S266435AbSKZRlL>;
	Tue, 26 Nov 2002 12:41:11 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: "Rusty Lynch" <rusty@linux.co.intel.com>, <trog@wincom.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Date: Tue, 26 Nov 2002 12:57:19 -0500
Subject: Re: A Kernel Configuration Tale of Woe
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3de3b72d.10eb.0@wincom.net>
X-User-Info: 129.9.26.53
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So how would you deal with somebody contributing bogus 
> mappings? What if somebody was just wrong, or uploading a 
> mapping in error?

Well, then the next time somebody queried that mapping and got back the config,
it wouldn't work. And they'd either fix it, or complain to someone who would
fix it.

So its inherently self-correcting.

DG
