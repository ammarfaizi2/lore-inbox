Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVAGAvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVAGAvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVAGAtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:49:42 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:24531 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261180AbVAGAoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:44:07 -0500
Subject: Re: 2.6.10-mm2: swsusp regression
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050107002921.GA1300@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <200501061848.11719.rjw@sisk.pl> <20050106225233.GD2766@elf.ucw.cz>
	 <200501070041.43023.rjw@sisk.pl> <20050106234829.GF28777@elf.ucw.cz>
	 <1105057470.3254.0.camel@desktop.cunninghams>
	 <20050107002921.GA1300@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1105058714.3260.0.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 07 Jan 2005 11:45:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-01-07 at 11:29, Pavel Machek wrote:
> Hi!
> 
> > AMD64 doesn't have MTRRs, does it? If it does, I'd bet on an SMP
> > hang.
> 
> I bet AMD64 does have MTRRs. It is backward compatible to i386,
> remember?

Makes sense. I just have this idea that I was told it doesn't :> *shrug*

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

