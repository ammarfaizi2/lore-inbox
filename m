Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUCBVmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUCBVkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:40:15 -0500
Received: from pop.gmx.net ([213.165.64.20]:28058 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261728AbUCBVjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:39:55 -0500
X-Authenticated: #4512188
Message-ID: <4044FF2A.3050507@gmx.de>
Date: Tue, 02 Mar 2004 22:39:54 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm1, as scheduler causes higher idle temp?
References: <20040229140617.64645e80.akpm@osdl.org>	<404367C2.3050109@gmx.de>	<40448E60.5020403@gmx.de>	<4044F25E.3010802@gmx.de> <20040302131139.0521b9d0.akpm@osdl.org>
In-Reply-To: <20040302131139.0521b9d0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>-Linux version 2.6.3-mm4 (root@tachyon) (gcc-Version 3.3.3 20040217 
>>+Linux version 2.6.4-rc1 (root@tachyon) (gcc-Version 3.3.3 20040217 
> 
> 
> The CFQ elevator is not present in Linus's tree.

Aargghh, something seemed to have gone wrong on patching to the latest 
mm kernel then. *blush*. Well, I'll try again...

Prakash
