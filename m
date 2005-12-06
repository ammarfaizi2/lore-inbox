Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVLFUk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVLFUk0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVLFUk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:40:26 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:3392 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030229AbVLFUkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:40:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rpGE0J+0os3gUTKKIGMeOii4zX+7eGQm+UllmAw9kjWBocGe560aGDvnPlPrMErG7QgcKCfTebEXZsNSnlkL1XxG/d4fjwUyzEmsi8ZB9aYYFxCUZWmvU4pLS8SIMMMTEbRb/jvOIWlLqUd76Zy56GquoBqodCGRyE53oKaPDzI=
Message-ID: <4395F733.3080501@gmail.com>
Date: Tue, 06 Dec 2005 22:40:19 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051014 Thunderbird/1.0.7 Mnenhy/0.7.2.0
MIME-Version: 1.0
To: Richard Knutsson <ricknu-0@student.ltu.se>
CC: Matthias Andree <matthias.andree@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <1133630556.22170.26.camel@laptopd505.fenrus.org> <20051203230520.GJ25722@merlin.emma.line.org> <43923DD9.8020301@wolfmountaingroup.com> <20051204121209.GC15577@merlin.emma.line.org> <1133699555.5188.29.camel@laptopd505.fenrus.org> <20051204132813.GA4769@merlin.emma.line.org> <1133703338.5188.38.camel@laptopd505.fenrus.org> <20051204142551.GB4769@merlin.emma.line.org> <43930A5F.9050802@student.ltu.se>
In-Reply-To: <43930A5F.9050802@student.ltu.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson wrote:
> But I do wonder how copyright and GPL can co-exist. Do the copyright 
> holder own the changes anybody else does to the code?
> Anyone care to explain?

IANAL, but GPL is a copyright license. Copyright is the right to make copies of 
somethings, to distribute it to be precise.

So if I write foo.c and release it under the GPL, and JR Hacker takes it and 
writes foo++.c but doesn't give his super duper sekrit version to anyone, then 
he isn't bound by copyright laws (he isn't making copies) and therefore the GPL 
doesn't hold for him.

The moment he wants to give a copy to his best friend, the GPL does kick in, 
though, and he has to abide by the GPL and distribute the whole piece (as it is 
a "derivative work") with the source code included (or an offer, or whatever. 
Read the GPL sometime, its not legalese at all).

For more information, ask your friendly (*cough*) neighborhood lawyer.

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

