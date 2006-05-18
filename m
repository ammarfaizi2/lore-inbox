Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWEREyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWEREyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWEREyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:54:31 -0400
Received: from mail.aknet.ru ([82.179.72.26]:33041 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750876AbWEREyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:54:31 -0400
Message-ID: <446BFE01.7030103@aknet.ru>
Date: Thu, 18 May 2006 08:54:25 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] add input_enable_device()
References: <20060518043121.39140.qmail@web81108.mail.mud.yahoo.com>
In-Reply-To: <20060518043121.39140.qmail@web81108.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
>>>> Why does it have the INPUT_DEVICE_ID_MATCH_BUS after all?
>>> For userspace benefits.
>> How exactly does the userspace benefit from the
>> INPUT_DEVICE_ID_MATCH_BUS thing?
This is still not answered. If INPUT_DEVICE_ID_MATCH_BUS
is there, then I don't see the argument that the input
layer is not designed for the like things.

> You just do not want to implement proper access control for the
> hardware, that's it.
Depends on an answer to the question above, whether using
input is the proper way or not.

