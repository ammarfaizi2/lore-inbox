Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbTAEXyU>; Sun, 5 Jan 2003 18:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTAEXyT>; Sun, 5 Jan 2003 18:54:19 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:26852 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S264983AbTAEXyT>; Sun, 5 Jan 2003 18:54:19 -0500
Date: Mon, 06 Jan 2003 13:01:41 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>,
       Andre Hedrick <andre@linux-ide.org>
cc: "Adam J. Richter" <adam@yggdrasil.com>, lm@bitmover.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, paul@clubi.ie
Subject: Re: Honest does not pay here ...
Message-ID: <2209530000.1041811301@localhost.localdomain>
In-Reply-To: <1041805731.1052.4.camel@aurora.localdomain>
References: <Pine.LNX.4.10.10301051223130.421-100000@master.linux-ide.org>
 <1041805731.1052.4.camel@aurora.localdomain>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, January 05, 2003 17:28:52 -0500 "Trever L. Adams" 
<tadams-lists@myrealbox.com> wrote:

>
> I am ardent supporter of the GPL.  I do have some problems with what
> some people are doing (particularly Nvidia, namely because I believe if
> I pay for hardware, I pay for the right to use it and to have the specs
> on how to use it... i.e. they don't release programming info).  However,
> Linus has allowed for binary only modules.

>
> Trever

I've had some discussion with an ex-NVidia guy who was there while they 
were doing the driver release.

They wanted to dual GPL/BSD license the kernel part in the first place, 
then they realised they had a problem.  They don't own the copyright on all 
that code themselves, nor do they have the right to redistribute specs for 
all of the hardware without NDA, because it consists in part of purchased 
'IP blocks' (as hardware people call libraries).  So in the end they've 
opened up as far as they were allowed by preexisting constraints.

Remember, the hardware was not constructed with an open source driver in 
mind.  It's fairly easy to build hardware which can have open source 
drivers (you choose your IP block vendors carefully), but NVidia did not do 
that in the first place, and now they are stuck.

So your belief about hardware is just plain false, unfortunately.  You're 
free not to buy their hardware, but I don't think you are being fair to dis 
them when they appear to have gotten the point of open source but been 
stymied by other vendors.  NVidia do try hard to give you the right to use 
their stuff with Linux, but there is only so far they can go.

I expect if Linux makes them enough money, they might buy the rights they 
don't have, and release the driver in full.  But don't expect that to 
happen soon, because if you think proprietary software licenses can be 
expensive, you haven't seen hardware.

Andrew
