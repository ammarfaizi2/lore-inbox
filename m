Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTLEHu0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 02:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTLEHu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 02:50:26 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:52749 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263956AbTLEHuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 02:50:18 -0500
Message-ID: <3FD03CD9.8020103@nishanet.com>
Date: Fri, 05 Dec 2003 03:07:53 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The x Bit Problem
References: <16333.14692.61778.304155@pc7.dolda2000.com>	 <3FCD47C4.50500@ninja.dynup.net> <3FCE39B8.20307@namesys.com>	 <16334.15412.686909.927196@laputa.namesys.com> <1070580817.8344.140.camel@arabia.home.lan> <3FD00086.90607@ninja.dynup.net> <3FD01679.3040007@mrs.umn.edu>
In-Reply-To: <3FD01679.3040007@mrs.umn.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Miner wrote:

> An interesting thing I discovered is that Windows simply ignores the 
> 'x' bit (I should say the Windows equivalent of the 'x' bit, called 
> "traverse folder / execute file"), but there is a policy setting that 
> overrides this attribute.
>
> I know users get tripped up on this a lot in Unix, like when they 
> don't understand why the webserver can't read their public_html 
> directory.  It might be a good option for Linux.
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Windows doesn't just ignore it. When I move
files from win to linux all the x bits are turned
on so txt and bz2 and jpg files are marked
executable. That's annoying and a security
risk.

-Bob

