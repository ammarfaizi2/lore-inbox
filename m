Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288971AbSBDN3Z>; Mon, 4 Feb 2002 08:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288973AbSBDN3O>; Mon, 4 Feb 2002 08:29:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40607 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288971AbSBDN3E>; Mon, 4 Feb 2002 08:29:04 -0500
Message-ID: <3C5E8D84.5216D0EC@in.ibm.com>
Date: Mon, 04 Feb 2002 19:02:52 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
Organization: IBM
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sathish jayapalan <sathish_jayapalan@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to crash a system and take a dump?
In-Reply-To: <20020204112621.31480.qmail@web14805.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With LKCD, you can also trigger a dump via the Alt+Sysrq+c key. 
If you run into problems when trying to use this, then you might need
some of the fixes that we've checked into the lkcd cvs tree.

Regards
Suparna
IBM Linux Technology Center

sathish jayapalan wrote:
> 
> Hi,
> I have a doubt. I know that linux kernel doesn't crash
> so easily. Is there any way to panic the system? Can I
> go to the source area and insert/modify a variable in
> kernel code so that the kernel references a null
> pointer and crashes while running the kernel compiled
> with this variable. My aim is to learn crash dump
> analysis with 'Lcrash tool". Please help me out with
> this.
> 
> Thanks in advance,
> sathish
> 
> __________________________________________________
> Do You Yahoo!?
> Great stuff seeking new owners in Yahoo! Auctions!
> http://auctions.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
