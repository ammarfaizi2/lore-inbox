Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWABNkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWABNkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWABNkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:40:23 -0500
Received: from smtp.rdslink.ro ([193.231.236.97]:19607 "EHLO smtp.rdslink.ro")
	by vger.kernel.org with ESMTP id S1750722AbWABNkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:40:22 -0500
X-Mail-Scanner: Scanned by qSheff 1.0 (http://www.enderunix.org/qsheff/)
Date: Mon, 2 Jan 2006 15:40:08 +0200 (EET)
From: caszonyi@rdslink.ro
X-X-Sender: sony@grinch.ro
Reply-To: Calin Szonyi <caszonyi@rdslink.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: mtrr: 0xe4000000,0x4000000 overlaps existing 0xe4000000,0x800000
In-Reply-To: <43B929C5.6050602@rainbow-software.org>
Message-ID: <Pine.LNX.4.62.0601021539550.1829@grinch.ro>
References: <1136173074.6553.2.camel@mindpipe> <43B929C5.6050602@rainbow-software.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2006, Ondrej Zary wrote:

> Lee Revell wrote:
>> I got this in dmesg with 2.6.14-rc7 when I restarted X with
>> ctrl-alt-backspace due to a lockup.  Is it a kernel bug or an X problem?
>> 
> I see that always when starting X:
> mtrr: 0xe1000000,0x800000 overlaps existing 0xe1000000,0x400000
>

Same here
mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x2000000

It appeared around kernel 2.6.14


--


