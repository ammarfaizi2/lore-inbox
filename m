Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272377AbTHECVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272375AbTHECVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:21:42 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:52179
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S272373AbTHECVi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:21:38 -0400
Message-ID: <5793.199.181.174.146.1060050091.squirrel@www.blazebox.homeip.net>
In-Reply-To: <1352160000.1060025773@aslan.btc.adaptec.com>
References: <20030801182207.GA3759@blazebox.homeip.net>	
    <20030801144455.450d8e52.akpm@osdl.org>	
    <20030803015510.GB4696@blazebox.homeip.net>	
    <20030802190737.3c41d4d8.akpm@osdl.org>	
    <20030803214755.GA1010@blazebox.homeip.net>	
    <20030803145211.29eb5e7c.akpm@osdl.org>	
    <20030803222313.GA1090@blazebox.homeip.net>	
    <20030803223115.GA1132@blazebox.homeip.net>	
    <20030804093035.A24860@beaverton.ibm.com>
    <1060021614.889.6.camel@blaze.homeip.net>
    <1352160000.1060025773@aslan.btc.adaptec.com>
Date: Mon, 4 Aug 2003 22:21:31 -0400 (EDT)
Subject: Re: Badness in device_release at drivers/base/core.c:84
From: "Paul Blazejowski" <paulb@blazebox.homeip.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: "Patrick Mansfield " <patmans@us.ibm.com>,
       "Andrew Morton " <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
User-Agent: SquirrelMail/1.5.0 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Priority: 3
Importance: Normal
Content-Transfer-Encoding: 7BIT
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.20.0.1; VDF: 6.20.0.55; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> You might be able to get useful information without using a serial
> console if you turn off your CDROM drives so they don't add extra output,
> but your best bet is to use a serial console.
>
> --
> Justin
>
>
>

Justin,

I am going to try with the SCSI disk drive alone after diconnecting the
cdrom drivers.

I'll look into serial console and try to set it up.Do i need extra
hardware or cables to run serial console? any poniters or setup
suggestions would be welcome as i never used serial consoles before.
Regards,

Paul
