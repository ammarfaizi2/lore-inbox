Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273465AbRIULmV>; Fri, 21 Sep 2001 07:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273450AbRIULmB>; Fri, 21 Sep 2001 07:42:01 -0400
Received: from t2.redhat.com ([199.183.24.243]:49394 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S273446AbRIULlx>; Fri, 21 Sep 2001 07:41:53 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200109202208.f8KM8o902962@deathstar.prodigy.com> 
In-Reply-To: <200109202208.f8KM8o902962@deathstar.prodigy.com> 
To: davidsen@tmr.com (bill davidsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockup with 2.4.9-ac10 on Athlon 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Sep 2001 12:42:12 +0100
Message-ID: <10119.1001072532@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davidsen@tmr.com said:
>  Look for BIOS updates. I have a BP6 (dual Celeron) system, and I am
> really disappointed that the only way I can power it down under
> software control is to boot to another o/s. You may be able to get a
> BIOS which works.

Strange - mine works. Either with APM and 'apm=power-off' on the command 
line, or with ACPI and a hack to work around the incompetence of Abit's 
BIOS engineers.

Me: "There's a one-char typo in your ACPI bytecode which prevents it from 
	working. This is the fix...."
Abit: "You can work around that by turning off ACPI support in the BIOS 
	setup"
Me: "But that just disables it, and makes it continue to not work. To make
	it work, it needs to be enabled - but there's a simple typo which
	prevents it from working."
Abit: <silence>

Sometimes it amazes me just how stupid some people can be and still 
actually keep their job.

--
dwmw2


