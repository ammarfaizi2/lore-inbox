Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289124AbSA1ObF>; Mon, 28 Jan 2002 09:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289171AbSA1Oa4>; Mon, 28 Jan 2002 09:30:56 -0500
Received: from web9205.mail.yahoo.com ([216.136.129.38]:45329 "HELO
	web9205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289124AbSA1Oao>; Mon, 28 Jan 2002 09:30:44 -0500
Message-ID: <20020128143044.8871.qmail@web9205.mail.yahoo.com>
Date: Mon, 28 Jan 2002 06:30:44 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: I've stopped the 'Spurious interrupts on IRQ7'
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
In-Reply-To: <200201280846.g0S8k1E22015@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> On 28 January 2002 06:37, Alex Davis wrote:
> > I added the following line to /etc/lilo.conf
> >
> > append = "parport=0x378,7"
> >
> > and re-ran lilo. I also noticed that the 'ERR' field in
> > /proc/interrupts stays at 0, whereas before the mod it
> > was increasing.
> 
> Do you have a printer?
Yes.
> Try to boot while it is powered off.
Spurious ints. occur whether the printer is on of off.


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
