Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272494AbRH3Vbr>; Thu, 30 Aug 2001 17:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271364AbRH3Vbi>; Thu, 30 Aug 2001 17:31:38 -0400
Received: from dsl092-103-029.nyc2.dsl.speakeasy.net ([66.92.103.29]:7953 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S270165AbRH3Vb0>; Thu, 30 Aug 2001 17:31:26 -0400
In-Reply-To: <fa.c2tt6vv.1d7aebo@ifi.uio.no>
In-Reply-To: <fa.c2tt6vv.1d7aebo@ifi.uio.no> 
From: "Sam Varshavchik" <mrsam@courier-mta.com>
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATAPI Floppy Problem
Date: Thu, 30 Aug 2001 21:31:45 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3B8EB0C1.0000262A@ny.email-scan.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber writes: 

> I get the following error on reboot... 
> 
> Aug 30 02:31:17 boolean kernel: ide-floppy: hdc: I/O error, pc = 5a, key = 
>  5, asc = 24, ascq =  0 
> 
> I have a ZIP 100, and am currently using ide-floppy driver 0.97 (included 
> with linux 2.4.9). 
> 
> Suggestions?

This should be fixed in -ac4.  It's a bogus message.  Ignore it. 

What is the vendor identification on this unit? 


-- 
Sam 

