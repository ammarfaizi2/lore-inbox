Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422960AbWAMVEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422960AbWAMVEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422961AbWAMVEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:04:42 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:35221 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422960AbWAMVEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:04:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TdXjKJjlEXYKJ5lnbgEvJ+i8Eu5Ld8MF32SCga3Wjk8vcikiVjrS1RL/qImT3q9Ffnm+pBZLmweZURuIMVugijWNb0p3RhGfXklCoRP0py12CpICqxBd2bdyVzSpOgYfwOMQW6WKE+tNGSkGuI1a7VSLJNQYFi4UIB4VLFcCmGY=
Message-ID: <43C815E3.10005@gmail.com>
Date: Fri, 13 Jan 2006 23:04:35 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051014 Thunderbird/1.0.7 Mnenhy/0.7.2.0
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Greg KH <greg@kroah.com>
Subject: Re: [patch 00/62] sem2mutex: -V1
References: <20060113124402.GA7351@elte.hu> <200601131400.00279.baldrick@free.fr> <20060113134412.GA20339@elte.hu> <200601131925.34971.ioe-lkml@rameria.de> <20060113195658.GA3780@elte.hu>
In-Reply-To: <20060113195658.GA3780@elte.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Ingo Oeser wrote:
>> Could we get for each of these and a mutex:
>>
>>  - description 
>>  - common use case
>>  - small argument why this and nothing else should be used there
> 
> like ... Documentation/mutex-design.txt?

I think what he wanted was an explanation for the change of each and every 
sem... Which is kind of hard with automated tools.

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

