Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWIZVnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWIZVnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWIZVnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:43:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:21567 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964835AbWIZVnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:43:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bPUhypHUEBSsaIRaEMjC44zKFVMGaNSUVHkG3CMaKqS5cgSPuwON/HJRNNGElxu40nlA6eWvsY7YrJSXtWzYIgtq6YhO85uTs5DBtwnm443n4Eue2rSM9FFpg47ukscjYyYs4mWSuVqXfyMXtyuvAlDTRfuuci5hKF0Ql2LXuNU=
Message-ID: <45199EEB.5040402@gmail.com>
Date: Tue, 26 Sep 2006 23:43:07 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, support@moxa.com.tw
Subject: Re: [PATCH 2/3] Char: mxser_new, upgrade to 1.9.1
References: <87473798798444375@wsc.cz> <20060926141149.3e3e3a4c.akpm@osdl.org>
In-Reply-To: <20060926141149.3e3e3a4c.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 24 Sep 2006 13:58:58 -0700
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> I also added printk line with info, if somebody wants to test it, he may
>> contact me as I can potentially debug the driver with him or just to
>> confirm it works properly.
> 
> hm, so you don't actually have a known tester for this?

There were some people, that told me it doesn't work but they can't (or don't 
want) to unapply patch-serie.

> <goes on a little hunt>
> 
> These people:
> 
> Bernard Pidoux <pidoux@ccr.jussieu.fr>

He unfortunately doesn't have the card. His friend had, before he passed away.

> Sergei Organov <osv@javad.com>
> 
> appear to have the hardware and are using this driver. 
> 
> Also Denis Vlasenko <vda@ilport.com.ua>, who is a kernel developer.

I'll try these two fellows, thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
