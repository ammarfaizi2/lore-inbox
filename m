Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311802AbSCNVkk>; Thu, 14 Mar 2002 16:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311805AbSCNVka>; Thu, 14 Mar 2002 16:40:30 -0500
Received: from mono.mweb.co.za ([196.2.53.170]:45325 "EHLO mono.mweb.co.za")
	by vger.kernel.org with ESMTP id <S311802AbSCNVkR>;
	Thu, 14 Mar 2002 16:40:17 -0500
Subject: Re: linux 2.2.21 pre3, pre4 and rc1 problems. (fwd)
From: Bongani <bonganilinux@mweb.co.za>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: M Sweger <mikesw@ns1.whiterose.net>, linux-kernel@vger.kernel.org,
        alan@redhat.com
In-Reply-To: <E16lcxr-0001wc-00@the-village.bc.nu>
In-Reply-To: <E16lcxr-0001wc-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-4mdk 
Date: 14 Mar 2002 23:53:54 +0200
Message-Id: <1016142855.14838.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-14 at 23:40, Alan Cox wrote:
> > v2.2.21pre4      hangs on boot after the message
> > 		 "Intel machine check architecture supported"
> 
> Fixed..
> 
what causes that 'cause I've been battling with that for a  while
on 2.4.19-pre3 and 2.4.19-pre3-aa1. I put a couple of printk's to see
where the problem was (arch/i386/bluesmoke.c), but after rebooting it
did not show up. I just vompiled 2.4.19-pre3-aa and 2.4.19-pre3 +
preempt, I would like o have it solved before I reboot though

thanx
	-Bongani

