Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbRCAQow>; Thu, 1 Mar 2001 11:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbRCAQom>; Thu, 1 Mar 2001 11:44:42 -0500
Received: from [62.90.5.51] ([62.90.5.51]:37896 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S129712AbRCAQoa>;
	Thu, 1 Mar 2001 11:44:30 -0500
Message-ID: <F1629832DE36D411858F00C04F24847A11DED1@SALVADOR>
From: Ofer Fryman <ofer@shunra.co.il>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Intel-e1000 for Linux 2.0.36-pre14
Date: Thu, 1 Mar 2001 18:49:07 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Richard,

I guess I have know choice but to try your suggestion.

Ofer

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
Sent: Thursday, March 01, 2001 6:02 PM
To: kernel@kvack.org
Cc: Ofer Fryman; 'linux-kernel@vger.kernel.org'
Subject: Re: Intel-e1000 for Linux 2.0.36-pre14


On Thu, 1 Mar 2001 kernel@kvack.org wrote:

> On Thu, 1 Mar 2001, Ofer Fryman wrote:
> 
> > I managed to compiled e1000 for Linux 2.0.36-pre14, I can also load it
> > successfully. 
> > With the E1000_IMS_RXSEQ bit set in IMS_ENABLE_MASK I get endless
interrupts
> > and the computer freezes, without this bit set it works but I cannot
receive
> > or send anything.
> 
> Intel refuses to provide complete documentation for any of their ethernet
> cards.  I recommend purchasing alternative products from vendors like 3com
> and National Semiconduct who are cooperative in providing data needed by
> the development community.
> 

Well Intel has been a continual contributor to Linux and BSD. Somebody
is not getting to the right person. There are lazy people at all
companies. 

Here is a compressed `grep` of linux-kernel mail headers from Intel
who had something useful to say during the past year. Maybe you
can ask one of them for the information you need? You just need to
find an advocate at a big company.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.

