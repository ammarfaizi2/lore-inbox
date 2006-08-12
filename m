Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWHLRfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWHLRfT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWHLRfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:35:19 -0400
Received: from mail.tmr.com ([64.65.253.246]:7097 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S964933AbWHLRfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:35:18 -0400
Message-ID: <44DE123E.20806@tmr.com>
Date: Sat, 12 Aug 2006 13:39:10 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ipw2200 doesn't load firmware on battery-powered boot
References: <5a4c581d0608091105r2e43bd9bx1bd78b2280dca13b@mail.gmail.com>
In-Reply-To: <5a4c581d0608091105r2e43bd9bx1bd78b2280dca13b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> Dell Latitude D610, FC5, happens at least since 2.6.18-rc2 and
> it's fully reproducable. Sorry for not reporting earlier but I've been
> recently either on vacation or very busy...

FWIW I saw FC4 do the same thing with the first 2.6.17 kernel. Didn't 
have time to investigate, so didn't report, just a suggestion that it 
may be something which happened earlier. I was going to look for a more 
recent version of the firmware, but the 2.6.16 is working fine, so I put 
it on hold, for a cold winter day.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
