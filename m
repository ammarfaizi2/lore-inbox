Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbTLFQHb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 11:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbTLFQHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 11:07:31 -0500
Received: from mail.g-housing.de ([62.75.136.201]:21408 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S265206AbTLFQH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 11:07:29 -0500
Message-ID: <3FD1F09D.6020501@g-house.de>
Date: Sat, 06 Dec 2003 16:07:09 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031203 Thunderbird/0.4RC2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samium Gromoff <deepfire@ibe.miee.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT] Rootkit queston
References: <874qwehxf1.wl@drakkar.ibe.miee.ru>
In-Reply-To: <874qwehxf1.wl@drakkar.ibe.miee.ru>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff wrote:
> On Mon, 1 Dec 2003, Richard B. Johnson wrote:
> 
>>You can check for a common 'root attack', if you have inetd,
>>by looking at the last few lines in /etc/inetd.conf.
>>It may have some access port added that allows anybody
>>who knows about it to log in as root from the network.
>>It will look something like this:
>>
>># End of inetd.conf.
>>4002 stream tcp nowait root /bin/bash --
>>

[...]

> 
> How is it an attack?
> 	(in order to write to inetd.conf you need to be root already)

he probably meant "rootkit" instead of "root attack" and as the subject 
reveals, that's what the thread was all about.

Christian.
-- 
BOFH excuse #13:

we're waiting for [the phone company] to fix that line
