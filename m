Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbVGARyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbVGARyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 13:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbVGARyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 13:54:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:61145 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263415AbVGARyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 13:54:17 -0400
Message-ID: <42C582CC.5050907@free.fr>
Date: Fri, 01 Jul 2005 19:52:12 +0200
From: Olivier Croquette <ocroquette@free.fr>
Reply-To: ocroquette@free.fr
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: setitimer expire too early (Kernel 2.4)
References: <42C444AA.2070508@free.fr>	<20050630165053.GA8220@logos.cnet> <20050630160537.7d05d467.akpm@osdl.org>
In-Reply-To: <20050630160537.7d05d467.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>Linus, Andrew, do you consider this critical enough to be merged to 
>>the v2.4 tree?
> 
> 
> No.  I'd expect this would hurt more people than it would benefit.


Probably.
Does that mean that the kernel 2.4 will keep this bug for ever?

