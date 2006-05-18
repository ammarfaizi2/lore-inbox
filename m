Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWERPe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWERPe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWERPe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:34:57 -0400
Received: from smtp2.int-evry.fr ([157.159.10.45]:37341 "EHLO
	smtp2.int-evry.fr") by vger.kernel.org with ESMTP id S1751368AbWERPe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:34:56 -0400
Message-ID: <446C9434.9010701@int-evry.fr>
Date: Thu, 18 May 2006 17:35:16 +0200
From: Florent Thiery <Florent.Thiery@int-evry.fr>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
Cc: openezx-devel@lists.gnumonks.org, linux-kernel@vger.kernel.org
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org> <446C5780.7050608@int-evry.fr> <20060518143824.GC17897@sunbeam.de.gnumonks.org>
In-Reply-To: <20060518143824.GC17897@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-INT-MailScanner-Information: Please contact the ISP for more information
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-MailScanner-From: florent.thiery@int-evry.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No, this touchscreen actually has fairly reasonable pressure reporting.
> I know that this is unusual.  But I get reproducible numbers when trying
> soft stylus press, hard stylus press.  And things like finger touching.
> Also I can actually distinguish a thumb from an index finger press ;)
>
>   
This is GREAT !!! because:
- with some embedded drawing app, you can paint !!! (this is interesting 
for me)
- we can have a "finger" detection feature, which could allow do trigger 
the switch to "finger mode" (bigger buttons etc)
> not that I've ever noted.  But Motorola ignores many of the hardwares
> capability..
>
>   
That's the purpose of openezx (and open source in general) to unleash 
them :) What other hardware features could be improved?

Florent
