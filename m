Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131335AbRCNTI6>; Wed, 14 Mar 2001 14:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131336AbRCNTIr>; Wed, 14 Mar 2001 14:08:47 -0500
Received: from mail1.dexterus.com ([212.95.255.99]:18692 "EHLO
	mail1.dexterus.com") by vger.kernel.org with ESMTP
	id <S131335AbRCNTIc>; Wed, 14 Mar 2001 14:08:32 -0500
Message-ID: <3AAFC15C.B2AA11DA@dexterus.com>
Date: Wed, 14 Mar 2001 19:07:08 +0000
From: Vincent Sweeney <v.sweeney@dexterus.com>
Organization: Dexterus
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcus Meissner <Marcus.Meissner@caldera.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: cpqarray & 2.4.1+ hang
In-Reply-To: <20010314192027.A11047@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Meissner wrote:
> 
> Workaround: run the kernel with the 'noapic' option on its commandline.
> 
> The ServerWorks chipset used in this Compaq Server somehow does not pass
> the the relevant information to Linux mapping routines. :/
> 
> I have attached lspci -xxx and dmesg output of our DL360 below.
> 
> Ciao, Marcus

Yes that workaround means no hang on bootup anymore, thanks a lot.

---
Vincent Sweeney
v.sweeney@dexterus.com
