Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132459AbRDCDFQ>; Mon, 2 Apr 2001 23:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132487AbRDCDE6>; Mon, 2 Apr 2001 23:04:58 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:56325 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132421AbRDCDEw>; Mon, 2 Apr 2001 23:04:52 -0400
Message-Id: <200104030303.f3333Ms00405@aslan.scsiguy.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Douglas Gilbert <dougg@torque.net>, Peter Daum <gator@cs.tu-berlin.de>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi bus numbering 
In-Reply-To: Your message of "Mon, 02 Apr 2001 19:59:15 EDT."
             <3AC91253.34E3C9DA@mandrakesoft.com> 
Date: Mon, 02 Apr 2001 21:03:22 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Justin T. Gibbs" wrote:
>> It is bogus that this stuff depends on link order to function
>> correctly.
>
>No, it is simply one more rule, and one that is not immediately
>obvious.  Take heart though.  Like Rolaids, 2.5's updated makefile
>system will bring relief...

Its not something the build system can "fix".  Its a design issue
that will have to be corrected by writing code.

--
Justin
