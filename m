Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSG3VDp>; Tue, 30 Jul 2002 17:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSG3VDo>; Tue, 30 Jul 2002 17:03:44 -0400
Received: from symphony-06.iinet.net.au ([203.59.3.38]:40456 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S316545AbSG3VDo>;
	Tue, 30 Jul 2002 17:03:44 -0400
Subject: Re: 2.5.25: spurious 8259A interrupt: IRQ7
From: Wade <neroz@iinet.net.au>
To: EricAltendorf@orst.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207301042.31667.EricAltendorf@orst.edu>
References: <200207300952.28460.EricAltendorf@orst.edu>
	<20020730175932.GA29379@darwin.crans.org> 
	<200207301042.31667.EricAltendorf@orst.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 31 Jul 2002 07:04:09 +1000
Message-Id: <1028063051.487.65.camel@debian>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 03:42, Eric Altendorf wrote: 
> OK -- I'll take that explanation.  I mentioned it because it happened 
> in the first half hour of using this kernel specifically, and I'd 
> never seen it before.
I only see this if I have IO-APIC turned on for a uniprocessor 
system. 


