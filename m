Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWABU1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWABU1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWABU1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:27:35 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:760 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751022AbWABU1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:27:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Gf/IL0gLWWnZsoOdajShFhgAn59x8e939oIdGPJ49tC8J64fKr0OIrx3G6KMqpBFcC0weLt0XI8i9t6mFBgyYe9yUQrQOvaSNsxZb3dygjKyUlSijPbkO/pj1OuPX05Jj3uz9ZsZMhyQTdQAVvnBCFPmCw+/bNlvjfBVyuYyhMo=
Message-ID: <43B98CAC.6060801@gmail.com>
Date: Mon, 02 Jan 2006 22:27:24 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051014 Thunderbird/1.0.7 Mnenhy/0.7.2.0
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org, kwall@kurtwerks.com
Subject: Re: Arjan's noinline Patch
References: <20060101155710.GA5213@kurtwerks.com> <20060102034350.GD5213@kurtwerks.com> <43B8FA70.2090408@gmail.com> <Pine.LNX.4.61.0601021949240.29938@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601021949240.29938@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Hi,
> size:
>     text    data     bss      dec     hex filename
> 17188479 5984442 1738248 24911169 17c1d41 rc7-noinl-Os/vmlinux
> 17313751 5980978 1738248 25032977 17df911 rc7-Os/vmlinux
> 20174873 5991726 1738248 27904847 1a9cb4f rc7-noinl/vmlinux
> 20222221 5992278 1738248 27952747 1aa866b rc7-NFI/vmlinux
> 20321527 5988706 1738248 28048481 1abfc61 rc7-std/vmlinux
> 
> 
> Jan Engelhardt

Just out of pure curiosity... Where would NFI-Os stand?

one would expect it to be around 17225???...

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

