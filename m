Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274426AbRJ2RdM>; Mon, 29 Oct 2001 12:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279303AbRJ2RdC>; Mon, 29 Oct 2001 12:33:02 -0500
Received: from t2.redhat.com ([199.183.24.243]:1014 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S274426AbRJ2Rcu>; Mon, 29 Oct 2001 12:32:50 -0500
Message-ID: <3BDD92E5.40EFFE90@redhat.com>
Date: Mon, 29 Oct 2001 17:33:25 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
Subject: Re: eepro100.c & Intel integrated MBs
In-Reply-To: <11361.1004374395@nova.botz.org> <3BDD8EEC.6DFE6BA5@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> Jurgen Botz wrote:
> 
> > I'm now using the e100 driver from the Intel web site, which works
> > perfectly, and light testing shows the Scyld (Don Becker) driver
> > to work as well.  The Intel driver seems to have an incompatible
> > license (noxious advertising clause?), but the Scyld drivers don't...
> > at least there isn't any license mentioned and of course many
> > of the net drivers in the current kernel are just earlier versions
> > of the Scyld drivers.
> 
> The Scyld drivers have only recently started working with the 2.4 series,
> and there is some unholly war between Becker and the rest of the kernel
> hackers...so I don't think you'll ever see his drivers in the standard
> kernel again...  RH usually tries to load the e100 (Intel's driver)
> instead of the eepro100. 

No we do not.  eepro100 is the default in Red Hat Linux 7.1 and 7.2 at
least.
I wish Intel would help fix eepro100 for the last few remaining issues
it has....
