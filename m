Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTJ3JDD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 04:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTJ3JDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 04:03:03 -0500
Received: from gprs197-81.eurotel.cz ([160.218.197.81]:52608 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262240AbTJ3JDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 04:03:00 -0500
Date: Thu, 30 Oct 2003 10:02:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: Pavel Machek <pavel@suse.cz>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Patrick Mochel <mochel@osdl.org>, John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031030090248.GB295@elf.ucw.cz>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com> <20031028093233.GA1253@elf.ucw.cz> <1067351431.1358.11.camel@teapot.felipe-alfaro.com> <20031028172818.GB2307@elf.ucw.cz> <1067372182.864.11.camel@teapot.felipe-alfaro.com> <20031029093802.GA757@elf.ucw.cz> <3FA0264B.4080505@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA0264B.4080505@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Not sure how it is supposed to work, but here I just have ntpd
> >step-setting by one hour...
> 
> It is really a time zone change....

I though so, but it does not work like that here.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
