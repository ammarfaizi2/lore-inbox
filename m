Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbUAIVYQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUAIVYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:24:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:1239 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264126AbUAIVYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:24:15 -0500
X-Authenticated: #4512188
Message-ID: <3FFF1BF3.4050209@gmx.de>
Date: Fri, 09 Jan 2004 22:24:03 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.1-mm1
References: <20040109014003.3d925e54.akpm@osdl.org>	<3FFED73D.8020502@gmx.de> <20040109132038.2dfaef02.akpm@osdl.org>
In-Reply-To: <20040109132038.2dfaef02.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
>>could it be that you took out /or forgot to insterst the work-around for 
>>nforce2+apic? At least I did a test with cpu disconnect on and booted 
> 
> I discussed it with Bart and he felt that it was not a good way of fixing
> the problem.  I'm not sure if he has a better fix in the works though..
> 
Yes, it is no good fix, but at least better than nothing...don't you agree?

Prakash
