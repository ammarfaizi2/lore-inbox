Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVJYQGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVJYQGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 12:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVJYQGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 12:06:23 -0400
Received: from smtp05.auna.com ([62.81.186.15]:35327 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S932193AbVJYQGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 12:06:23 -0400
In-Reply-To: <435E5720.6030105@tremplin-utc.net>
References: <20051023235806.1a4df9ab@werewolf.able.es>	<35fb2e590510231613u492d24c6k4d65ff3ac5ffcee6@mail.gmail.com> <20051024015710.29a02e63@werewolf.able.es> <435E5720.6030105@tremplin-utc.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <36402397-77C9-49A7-A143-2C672FC90934@able.es>
Cc: jonathan@jonmasters.org, jonmasters@gmail.com,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: /proc/kcore size incorrect ? (OT)
Date: Tue, 25 Oct 2005 18:06:17 +0200
To: Eric Piel <eric.piel@tremplin-utc.net>
X-Mailer: Apple Mail (2.734)
X-Auth-Info: Auth:PLAIN IP:[83.138.210.169] Login:jamagallon@able.es Fecha:Tue, 25 Oct 2005 18:06:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005.10.25, at 18:02, Eric Piel wrote:

> J.A. Magallon wrote:
> :
>
>> It looks really silly to have a motd say "wellcome to this box, it  
>> has
>> 2 xeons and 1022 Mb of RAM".
>>
> Ok, everyone seems to go with his idea on this thread so I'd like  
> to share mine too :-P
>
> If you want to know how much _physical_ memory there is on your  
> computer, then a good way would be too use dmidecode. The parsing  
> might require more work than a "du" but you will never have trouble  
> with rounding...
>

Yes, I know...

If you remember, the question about 'how to guess this box mem' was
under something like "BTW ...", kinda collateral.

My concerns were about if the size of /proc/kcore should be what it is
now, and why...

--
J.A. Magallon <jamagallon()able!es>   \          Software is like sex:
wolverine                              \    It's better when it's free
MacOS X 10.4.2, Darwin Kernel Version 8.2.0


