Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbSJSUyd>; Sat, 19 Oct 2002 16:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265678AbSJSUyd>; Sat, 19 Oct 2002 16:54:33 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:60581 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S265675AbSJSUyc>; Sat, 19 Oct 2002 16:54:32 -0400
Message-ID: <3187992.1035061003952.JavaMail.nobody@web54.us.oracle.com>
Date: Sat, 19 Oct 2002 13:56:43 -0700 (PDT)
From: Bert Barbe <BERT.BARBE@oracle.com>
To: rmk@arm.linux.org.uk, vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: Re: 2.4.19 orinoco_cs with Lucent WaveLAN "bronze"
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Oct 19, 2002 at 02:14:57PM +0000, Denis Vlasenko wrote:
> > Today I played with wireless LAN euqipment for the first time.
> > I have ISA-to-PCMCIA converter and a Lucent (IEEE) PCMCIA card.
> > I set up everything as directed by HOWTOs. I do:
> Yes, I also noticed many problems with the current orinoco_cs driver.


I have an orinocco gold. In 2.4.x<19 it gave me some errors in the logs also,
but despite that it seemed to work after setting the right options with iwconfig.
I haven't tested 2.4.19 with the orinioco_cs driver yet since I had other
problems with .19 before i got to that.

Regards,
Bert

