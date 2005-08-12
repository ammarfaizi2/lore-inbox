Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVHLB7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVHLB7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 21:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVHLB7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 21:59:41 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:31366 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932539AbVHLB7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 21:59:40 -0400
Message-ID: <42FC0269.4020307@gmail.com>
Date: Fri, 12 Aug 2005 03:59:05 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Masoud Sharbiani <masouds@masoud.ir>
CC: linux-kernel@vger.kernel.org
Subject: Re: System shutdown with during reboot with 2.6.13-pre6
References: <42FB89D1.1060007@masoud.ir> <42FBA220.8020508@gmail.com> <42FBB37E.6070607@masoud.ir>
In-Reply-To: <42FBB37E.6070607@masoud.ir>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masoud Sharbiani napsal(a):

> Hello,
> Adding reboot=w causes system to reboot properly.

It doesn't use interrupt now, it only jumps to one far address with one 
number saved in other place in memory,

> Is this a known issue with 2.6.latest ACPI or is it that my mainboard 
> is broken?

No, I don't know about anybody, who has the same problem (it doesn't 
mean, that it couldn't be).
Did it work before? Could you accurate version of kernel, where it stops 
working?

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

