Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbRGEOg5>; Thu, 5 Jul 2001 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265189AbRGEOgr>; Thu, 5 Jul 2001 10:36:47 -0400
Received: from t2.redhat.com ([199.183.24.243]:33268 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S265205AbRGEOgd>; Thu, 5 Jul 2001 10:36:33 -0400
Message-ID: <3B447B6D.C83E5FB9@redhat.com>
Date: Thu, 05 Jul 2001 15:36:29 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-11.3smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
In-Reply-To: <20010704232816.B590@marvin.mahowi.de> <20010705162035.Q17051@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Wed, Jul 04, 2001 at 11:28:17PM +0200, Manfred H. Winter wrote:
> > Hi!
> >
> > I tried to install kernel 2.4.6 with same configuration as 2.4.5, but
> > booting failed with:
> >
> > kernel BUG at softirq.c:206!
> 
> do you have any problem with those patches applied?
> 
>         ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/00_ksoftirqd-7
>         ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/00_softirq-fixes-4
> 

Is there anything in here that fixes a Via/Cyrix specific bug ?
