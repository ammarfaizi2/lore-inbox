Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWDKKZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWDKKZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWDKKZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:25:24 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:10814 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750712AbWDKKZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:25:23 -0400
Message-ID: <443B85B4.7030009@sw.ru>
Date: Tue, 11 Apr 2006 14:32:20 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>	<1143228339.19152.91.camel@localhost.localdomain>	<4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at>	<4428FB29.8020402@yahoo.com.au>	<20060328142639.GE14576@MAIL.13thfloor.at>	<44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442B4FD6.1050600@yahoo.com.au>
In-Reply-To: <442B4FD6.1050600@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes... about that; if/when namespaces get into the kernel, you guys
> are going to start pushing all sorts of per-container resource
> control, right? Or will you be happy to leave most of that to VMs?

Nick, OpenVZ, for example, uses "User Bean Counters" patch originally 
developed by Alan Cox. The good thing is that it is fully separate from 
virtualization and allows to control any users or set of processes. 
Don't you think it is valuable and helpful feature itself? Why are you 
afraid of resource management?

Thanks,
Kirill

