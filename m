Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUAZEuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 23:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbUAZEuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 23:50:32 -0500
Received: from main.gmane.org ([80.91.224.249]:12164 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265494AbUAZEub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 23:50:31 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: JustFillBug <mozbugbox@yahoo.com.au>
Subject: Re: [ANNOUNCE] Cooperative Linux
Date: Mon, 26 Jan 2004 03:57:00 +0000 (UTC)
Message-ID: <slrnc193vo.42h.mozbugbox@mozbugbox.somehost.org>
References: <20040125193518.GA32013@callisto.yi.org> <40148C1C.5040102@vgertech.com>
X-Complaints-To: usenet@sea.gmane.org
X-Mail-Copies-To: nobody
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-01-26, Nuno Silva <nuno.silva@vgertech.com> wrote:
>> Hello fellow developers, kernel hackers, and open source contributors,
>> 
>> Cooperative Linux is a port of the Linux kernel which allows it 
>> to run cooperatively under other operating systems in ring0 without 
>> hardware emulation, based on very minimal changes in the architecture 
>> dependent code and almost no changes in functionality.
>> 
>> The bottom line is that it allows us to run Linux on an unmodified
>> Windows 2000/XP system in a practical way (the user just launches 
>
> Very nice! Can we run two (or more) instances of Linux at the same time?
>
> When will you release a linux-as-host patch? :-)
>

How about a bare bone OS whose sole purpose is to run multiple OS on top
of it? A pure VM OS. 

