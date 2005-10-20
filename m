Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVJTRsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVJTRsv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 13:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVJTRsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 13:48:51 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:38825 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S932507AbVJTRsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 13:48:50 -0400
Message-ID: <4357CA5D.9060507@ens-lyon.fr>
Date: Thu, 20 Oct 2005 18:48:29 +0200
From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <xslaby@fi.muni.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Wifi oddness [Was: Re: 2.6.14-rc4-mm1]
References: <20051016154108.25735ee3.akpm@osdl.org> <20051019184935.E8C0B22AEB2@anxur.fi.muni.cz>
In-Reply-To: <20051019184935.E8C0B22AEB2@anxur.fi.muni.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
>>I've been having problems with ipw2200 oopsing at modprobe since
>>2.6.14-rc2-mm1 (sorry for not reporting before). I use the ipw2200
>>included in the kernel.
> 
> 
> Can you apply this and tell me what are the numbers?

Hi,

I tested with -rc4 and the problem did not appear.
As for your patch, it just says ---THIS: 0,0 before oopsing.

Hope it helps.

Regards,
Alexandre
