Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266058AbRGOLLN>; Sun, 15 Jul 2001 07:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266063AbRGOLLD>; Sun, 15 Jul 2001 07:11:03 -0400
Received: from 1Cust29.tnt1.cbr1.da.uu.net ([210.84.112.29]:53130 "EHLO
	backdraft") by vger.kernel.org with ESMTP id <S266058AbRGOLKv>;
	Sun, 15 Jul 2001 07:10:51 -0400
Date: Sun, 15 Jul 2001 21:10:34 +1000
From: Patrick Cole <z@amused.net>
To: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bridge and netfilter
Message-ID: <20010715211034.A20917@backdraft.amused.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lx7kxbxror.fsf@pixie.isr.ist.utl.pt>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Jul 14, 2001 at 07:59:32PM +0100, Rodrigo Ventura wrote:

>         Hi everyone. What's the current status of the kernel bridging
> code with respect to netfilter stack? We want to put a transparent
> firewall working. So we need to apply netfilter rules to the packets
> between two interfaces in the same bridge group.

>From what I've read the code is still experimental and there are a few
issues with it killing the machine. The 2.4 mainstream kernel has the 
hooks but an extra patch is required to get it going.

Pat

-- 
Patrick Cole  -  Debian Developer    <ltd@debian.org>
              -  Linux.com Volunteer <z@linux.com>
              -  ANU JCSMR ICU Staff <Patrick.Cole@anu.edu.au>
              -  PGP Key ID          6 0 D 7 4 C 7 D
                 
