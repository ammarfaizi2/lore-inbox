Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281604AbRKMLTN>; Tue, 13 Nov 2001 06:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281605AbRKMLTE>; Tue, 13 Nov 2001 06:19:04 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:25012 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S281604AbRKMLS5>; Tue, 13 Nov 2001 06:18:57 -0500
Message-ID: <3BF1020E.2AFEEEDC@oracle.com>
Date: Tue, 13 Nov 2001 12:20:46 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Airlie <airlied@skynet.ie>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI again in 2.4.15-pre4
In-Reply-To: <Pine.LNX.4.32.0111122334280.4284-100000@skynet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
> 
> I saw this first in 2.4.15-pre2 here it is again for pre4.
> 
> I've attached a cat /proc/pci which is bad, my Xircom doesn't show up,
> further down I've attached an lspci -v -H 1 and it has my Xircom on it ..
> 
> Anyone care to comment... this worked in 2.4.10 I'll try to patch up to
> 2.4.14 and see where it stared..
> 
> Dave.

Confirmed on -pre3 - Xircom RBEM56G100 is "invisible" to /proc/pci.

--alessandro

 "we live as we dream alone / to break the spell we mix with the others
  we were not born in isolation / but sometimes it seems that way"
     (R.E.M., live intro to 'World Leader Pretend')
