Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278758AbRJ3XZO>; Tue, 30 Oct 2001 18:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278748AbRJ3XZE>; Tue, 30 Oct 2001 18:25:04 -0500
Received: from freeside.toyota.com ([63.87.74.7]:48657 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S278736AbRJ3XZB>;
	Tue, 30 Oct 2001 18:25:01 -0500
Message-ID: <3BDF36E9.7FAE5D7A@lexus.com>
Date: Tue, 30 Oct 2001 15:25:30 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Dvorak <johnydog@go.cz>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [OT] Re: Nasty suprise with uptime
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com> <20011030235213.A854@go.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dvorak wrote:

> On Mon, Oct 29, 2001 at 12:39:37PM -0800, J Sloan wrote:
> > So, is there an implicit Linux policy to upgrade
> > the distro, or at least the kernel, every 496 days
> > whether it needs it or not?
>
> Rather, you should think about your poor hw. It's nice to sit down at least once
> a year, to clean up your box of that spider/ant feudalistic colonies, bug
> airports, to check connectors, upgrade some components, and other such things
> which you can't risk doing online at 32bit platform. You know, there are
> some x86s which wasn't projected to even LAST as long as one year :-)

Certainly a point -

It's not too unreasonable to bring down a
server for maintenance every 16 months.

However this is good, expensive  hardware...

Consider HP-UX 10.20, a 32-bit, 1996 vintage
commercial unix, in many ways somewhat
primitive compared to Linux:

root@zinc:/root# uname -a
HP-UX zinc B.10.20 U 9000/800 2003576880 unlimited-user license
root@zinc:/root# uptime
  3:24pm  up 681 days,  6:43,  12 users,  load average: 1.17, 1.15, 1.15

So clearly, it's not rocket science....

cu

jjs

