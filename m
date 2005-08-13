Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbVHMDPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVHMDPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 23:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVHMDPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 23:15:31 -0400
Received: from mail.tmr.com ([64.65.253.246]:3031 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750894AbVHMDPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 23:15:31 -0400
Message-ID: <42FD688E.7090106@tmr.com>
Date: Fri, 12 Aug 2005 23:27:10 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe <joecool1029@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: remove support for gcc < 3.2
References: <20050731222606.GL3608@stusta.de>	 <20050731.153631.70217457.davem@davemloft.net> <42FA5848.809@tmr.com> <d4757e6005081017024c3bf3fd@mail.gmail.com>
In-Reply-To: <d4757e6005081017024c3bf3fd@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe wrote:

>I'm for its removal. As for the gcc project "losing its way" consider
>that 3.4 has quite matured and also has much smaller binary size from
>3.3. 4.0 however is still too early in its development to come close
>to surpassing 3.4.
>

I consider that the compiler get bigger and slower with every release. 
The tools used to find overlong paths in the kernel would work well for 
gcc. Recent versions are painful, even with a decent SMP machine. The 
people compiling on laptops could spend a day building with new versions.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

