Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261815AbTCLRmU>; Wed, 12 Mar 2003 12:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbTCLRmU>; Wed, 12 Mar 2003 12:42:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:49889 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261815AbTCLRmT> convert rfc822-to-8bit; Wed, 12 Mar 2003 12:42:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
To: "David Shirley" <dave@cs.curtin.edu.au>,
       <vda@port.imtp.ilyichevsk.odessa.ua>, <linux-kernel@vger.kernel.org>
Subject: Re: Help, eth0: transmit timed out!
Date: Wed, 12 Mar 2003 18:52:44 +0100
User-Agent: KMail/1.4.3
References: <041b01c2e86a$870822f0$64070786@synack> <200303121353.h2CDrhu30117@Port.imtp.ilyichevsk.odessa.ua> <002101c2e8a5$8358d4c0$2400a8c0@compaq3>
In-Reply-To: <002101c2e8a5$8358d4c0$2400a8c0@compaq3>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303121852.44804.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 March 2003 15:41, David Shirley wrote:
> Tried a different NIC, another 3c905c.

..and? I'm using this NIC family with this driver in all my diskless setups 
with kernels since 2.0.* up to 2.4.20, and I never experienced the problem
you describe, so I would check for some hardware, bios, chipset, cable, hub
or switch problem.

>From about 30 NICs currently in production for 6 month up to 5 years, I had 
one failure (3c905b). I haven't found Don's driver failing since ages ;-), 
through the b versions created me some headaches for etherbooting and the
newest 3c905cx-txm has a problem with software bootprom flashing :-(.

Pete
