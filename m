Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312332AbSDJIVY>; Wed, 10 Apr 2002 04:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312413AbSDJIVY>; Wed, 10 Apr 2002 04:21:24 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:1783 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id <S312332AbSDJIVX>; Wed, 10 Apr 2002 04:21:23 -0400
Message-ID: <3CB3F5FF.7EBD0A19@bull.net>
Date: Wed, 10 Apr 2002 10:21:19 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: hu, fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re:  Event logging vs enhancing printk
In-Reply-To: <OF7FF94B66.91DD315B-ON88256B95.00811EF0@boulder.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am definitely *FOR* adding Enterprise Event Logging feature to Linux.

We are going to make "not too small, not too cheap" IA64 based machines
at Bull.
Having a full featured event logging subsystem is essential to provide
good services to our clients.

Most of the HW errors are just impossible to print out to the screen
(and capture them).
There are lots of boring details, binary data, it's not a print that
will help us.

People are negligent with prints. They feel free to print out anything
they think it is important.
You'll need an artificial intelligence if you want to make status
reports out of random prints.

Not losing error logs is essential.
I need a feed-back from the error logging subsystem saying that the log
is already stored on a permanent storage before I clear the firmware's
error report.

We should do at leas as well as Windows does the error handling, or even
better :-)

I am convenienced that Linux becomes a professional system and it needs
professional tools.

Thanks,

Zoltan Menyhart

P.S.: Please CC your answers to Zoltan.Menyhart@bull.net
