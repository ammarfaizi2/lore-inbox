Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265408AbRGEPcl>; Thu, 5 Jul 2001 11:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265411AbRGEPcb>; Thu, 5 Jul 2001 11:32:31 -0400
Received: from pop.gmx.net ([194.221.183.20]:51234 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265408AbRGEPcV>;
	Thu, 5 Jul 2001 11:32:21 -0400
Date: Thu, 5 Jul 2001 17:19:56 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705171955.A986@marvin.mahowi.de>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010705162035.Q17051@athlon.random>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.5 i686
X-Editor: VIM - Vi IMproved 5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli schrieb am Donnerstag, den 05. Juli 2001:

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
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/00_ksoftirqd-7
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/00_softirq-fixes-4
> 

I didn't know about these patches but I'll give them a try.

Manfred
-- 
 /"\                        | PGP-Key available at Public Key Servers
 \ /  ASCII ribbon campaign | or "http://www.mahowi.de/pgp/mahowi.asc"
  X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
 / \  and postings          | AIM: mahowi42   * ICQ: 61597169
