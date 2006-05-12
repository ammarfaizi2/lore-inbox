Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWELRWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWELRWc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWELRWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:22:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:48618 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751059AbWELRWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:22:31 -0400
Subject: Re: 2.6.17-rc3-mm1
From: john stultz <johnstul@us.ibm.com>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060512114142.GD6876@ens-lyon.fr>
References: <20060501014737.54ee0dd5.akpm@osdl.org>
	 <40f323d00605030211t78e41d18h298c8be3721a135a@mail.gmail.com>
	 <20060503064816.ef7ec2b7.akpm@osdl.org>
	 <1146665732.27820.75.camel@localhost.localdomain>
	 <20060503144318.GA5505@ens-lyon.fr> <20060505150509.GA16562@ens-lyon.fr>
	 <1146911438.7467.13.camel@localhost.localdomain>
	 <1147110520.13441.4.camel@localhost.localdomain>
	 <20060512114142.GD6876@ens-lyon.fr>
Content-Type: text/plain
Date: Fri, 12 May 2006 10:22:28 -0700
Message-Id: <1147454548.9343.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 13:41 +0200, Benoit Boissinot wrote:
> On Mon, May 08, 2006 at 10:48:39AM -0700, john stultz wrote:
> > Applying the patch here should get the ACPI PM working again.
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=f0ec5e39765cd254d436a6d86e211d81795952a4;hp=30d55280b867aa0cae99f836ad0181bb0bf8f9cb
> 
> I am running with the above patch for few days and I couldn't reproduce
> the bug with it. So it looks good.

Thanks for the testing!
-john


