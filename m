Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWBGKco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWBGKco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 05:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWBGKco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 05:32:44 -0500
Received: from mail.setcomm.ru ([83.102.151.194]:49612 "EHLO mail.setcomm.ru")
	by vger.kernel.org with ESMTP id S964840AbWBGKco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 05:32:44 -0500
Message-ID: <43E87749.8030206@kernelpanic.ru>
Date: Tue, 07 Feb 2006 13:32:41 +0300
From: "Boris B. Zhmurov" <bb@kernelpanic.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Rulez Forever/1.7.12-1.4.2
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Yoseph Basri <yoseph.basri@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
References: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com>
In-Reply-To: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Yoseph Basri.

On 07.02.2006 12:46 you said the following:

> I am getting the warning log:
> 
> kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at
> net/core/stream.c (279)
> kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at
> net/ipv4/af_inet.c (148)


Do you have Intel Pro 1000 network card? Same here...


-- 
Boris B. Zhmurov
mailto: bb@kernelpanic.ru
"wget http://kernelpanic.ru/bb_public_key.pgp -O - | gpg --import"

