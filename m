Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291745AbSCST12>; Tue, 19 Mar 2002 14:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291753AbSCST1I>; Tue, 19 Mar 2002 14:27:08 -0500
Received: from web21304.mail.yahoo.com ([216.136.129.190]:40573 "HELO
	web21304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S291745AbSCST04>; Tue, 19 Mar 2002 14:26:56 -0500
Message-ID: <20020319192644.9097.qmail@web21304.mail.yahoo.com>
Date: Tue, 19 Mar 2002 11:26:44 -0800 (PST)
From: chiranjeevi vaka <cvaka_kernel@yahoo.com>
Subject: Re: using kmalloc
To: James Washer <washer@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OFD9F443C5.CB1A619A-ON88256B81.005F0AD1@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jim,
I am trying to get something around 600 to 1000 bytes
using kmalloc. This one is for some changes in TCP/IP
stack. I am trying to implement a new kernel data
structure in tcp layer. So can you suggest me what
functionality to use to come out of that hanging.


thanks. 
--- James Washer <washer@us.ibm.com> wrote:
> 
> How much memory are you trying to get?  Also.. is
> this for a module, or a
> builtin function/driver/whatever?
>  - jim
> 
> chiranjeevi vaka
> <cvaka_kernel@yahoo.com>@vger.kernel.org on
> 03/19/2002
> 08:18:31 AM
> 
> Sent by:    linux-kernel-owner@vger.kernel.org
> 
> 
> To:    linux-kernel@vger.kernel.org
> cc:
> Subject:    using kmalloc
> 
> 
> 
> Hi,
> 
> I am getting some problems with kmalloc. If I tried
> to
> allocate more than certain memory then the system is
> hanging while booting with the changed kernel. Can
> you
> suggest me how to come out this situation. Can't I
> allocate as much I want when I want to allocate in
> the
> kernel.
> 
> 
> Thank you,
> Chiranjeevi
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Sports - live college hoops coverage
> http://sports.yahoo.com/
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
