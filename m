Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUFPVgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUFPVgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266317AbUFPVgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:36:14 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:2007 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S266316AbUFPVgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:36:05 -0400
Message-ID: <40D0BD42.1090007@tomt.net>
Date: Wed, 16 Jun 2004 23:36:02 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: root@chaos.analogic.com
Subject: Re: Programtically tell diff between HT and real
References: <20040616174646.70010.qmail@web51805.mail.yahoo.com>  <1087408567.7869.1.camel@localhost> <1087411607.7869.3.camel@localhost> <Pine.LNX.4.53.0406161644450.541@chaos>
In-Reply-To: <Pine.LNX.4.53.0406161644450.541@chaos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
>   mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
>                                                            ^_______
> bogomips	: 5570.56
> 
> I would love to know how you turn in on! This is one of those
> "latest-and-greatest" Intel D865PERL mother-boards and I've
> even flashed the BIOS with the "latest-and-greatest".

The usual way is to enable HT in BIOS, and use a SMP enabled kernel.

-- 
Cheers,
André Tomt
