Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTLCIPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 03:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbTLCIPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 03:15:39 -0500
Received: from legolas.restena.lu ([158.64.1.34]:56975 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264509AbTLCIPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 03:15:38 -0500
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
From: Craig Bradney <cbradney@zip.com.au>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: b@netzentry.com, ross.alexander@uk.neceur.com, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org, pomac@vapor.com, forming@charter.net
In-Reply-To: <3FCD32F5.2050002@gmx.de>
References: <3FCD21E1.5080300@netzentry.com>
	 <1070411338.2452.66.camel@athlonxp.bradney.info>  <3FCD32F5.2050002@gmx.de>
Content-Type: text/plain
Message-Id: <1070439330.2450.73.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Dec 2003 09:15:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-03 at 01:48, Prakash K. Cheemplavam wrote:
> > smp off, preempt off. lapic on, apic on, acpi on
> 
> Why haven't you enabled preempt? Does it lock with preempt on?
> 

Having been more a lurker on the list before this issue, I had read that
there were some preempt issues with 2.6.. so I turned it off. No idea if
it locks with preempt on. Next time I do a recompile Ill try it out.

Craig

> Prakash
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

