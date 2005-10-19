Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVJSQEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVJSQEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVJSQEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 12:04:24 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:58582 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1751141AbVJSQEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 12:04:23 -0400
Message-ID: <43566062.6080200@ens-lyon.fr>
Date: Wed, 19 Oct 2005 17:04:02 +0200
From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1
References: <20051016154108.25735ee3.akpm@osdl.org> <43565257.6020505@ens-lyon.fr> <43566BB7.8050100@gmail.com>
In-Reply-To: <43566BB7.8050100@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Alexandre Buisse napsal(a):
> 
> 
>>I've been having problems with ipw2200 oopsing at modprobe since
>>2.6.14-rc2-mm1 (sorry for not reporting before). I use the ipw2200
>> 
>>
> 
> 2.6.14-rc2 is OK (or what was the last OK)? There are no significant
> changes in rc2-mm1.

I use only -mm, and skipped 2.6.13-mm3. 2.6.14-rc1-mm1 had some other
oops and I didn't even try ipw2200. So last OK was 2.6.13-mm2 (which
I'm still using now)

> 
> ...oopsing at modprobe since... are you sure? This seems like an iwlist.

I meant that it oopsed just after I modprobed it. But as it makes a
iwlist just after having been loaded, I guess it is actually in an iwlist.

Regards,
Alexandre
