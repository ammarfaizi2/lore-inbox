Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVA0PSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVA0PSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVA0PSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:18:09 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:26508 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262641AbVA0PSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:18:06 -0500
Message-ID: <41F90697.5020408@tmr.com>
Date: Thu, 27 Jan 2005 10:19:51 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
References: <20050124175449.GK3515@stusta.de><20050124021516.5d1ee686.akpm@osdl.org> <20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Mon, 24 Jan 2005 18:54:49 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> 
>>It seems noone who reviewed the SuperIO patches noticed that there are 
>>now two modules "scx200" in the kernel...
> 
> 
> They are almost mutually exlusive(SuperIO contains more advanced), 
> so I do not see any problem here.
> Only one of them can be loaded in a time.
> 
> So what does exactly bother you?
>
That I don't know how to select loading between modules with the same 
name. What's the trick?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
