Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbTJaETP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 23:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTJaETP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 23:19:15 -0500
Received: from web12302.mail.yahoo.com ([216.136.173.100]:45476 "HELO
	web12302.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262948AbTJaETO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 23:19:14 -0500
Message-ID: <20031031041913.11804.qmail@web12302.mail.yahoo.com>
Date: Thu, 30 Oct 2003 20:19:13 -0800 (PST)
From: Vinayak Kariappa <c_vinayak@yahoo.com>
Subject: Re: 1-Wire bus kernel module
To: Jitendra Vegiraju <jvegiraju@frys.com>,
       linux-kernel maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FA14A18.6060802@frys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

could you give me more details about your board. Like
the architecture.
The code is very crude (some routines left as todos) ,
but supports multiple chips on the bus using search
rom. It has a very good proc interface.
I have tested with pc parallel port as the adapter and
two ds1820 chips on the bus. 


--- Jitendra Vegiraju <jvegiraju@frys.com> wrote:
> I would like to test it out on our board( has a
> 1-wire DS2415 RTC chip).
> Can  you please send  code.
> Thanks,
> Jitendra
> 
> Vinayak Kariappa wrote:
> 
> >Hi all,
> >
> >As a hobby, I have coded 1-wire bus driver similiar
> in
> >the  lines of i2c bus module architecture (clients,
> >adapter, drivers )for linux.
> >Please can you guide me to anyone who is already
> >maintaining such modules. I would be glad to share
> >it/join with them in development.
> >  
> >
> 
> 


__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
