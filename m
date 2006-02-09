Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWBITRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWBITRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWBITRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:17:31 -0500
Received: from mail.setcomm.ru ([83.102.151.194]:2445 "EHLO mail.setcomm.ru")
	by vger.kernel.org with ESMTP id S1750735AbWBITRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:17:30 -0500
Message-ID: <43EB9548.9060504@kernelpanic.ru>
Date: Thu, 09 Feb 2006 22:17:28 +0300
From: "Boris B. Zhmurov" <bb@kernelpanic.ru>
Reply-To: bb@kernelpanic.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Rulez Forever/1.7.12-1.4.2
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Yoseph Basri <yoseph.basri@gmail.com>, linux-kernel@vger.kernel.org,
       NetDEV list <netdev@vger.kernel.org>
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
References: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com> <4807377b0602081207s7604eceahb8bf4af6715a6534@mail.gmail.com>
In-Reply-To: <4807377b0602081207s7604eceahb8bf4af6715a6534@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jesse Brandeburg.

On 08.02.2006 23:07 you said the following:

> whats the relevance of e1000?
> 
> I though Herbert had fixed these

Nope :( I had this messages on 2.6.14.2 and now I have it on 2.6.15.3.


-- 
Boris B. Zhmurov
mailto: bb@kernelpanic.ru
"wget http://kernelpanic.ru/bb_public_key.pgp -O - | gpg --import"

