Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbSJTLl7>; Sun, 20 Oct 2002 07:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262440AbSJTLl7>; Sun, 20 Oct 2002 07:41:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:521 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262385AbSJTLl7>; Sun, 20 Oct 2002 07:41:59 -0400
Message-Id: <200210201142.g9KBgUp18341@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Bert Barbe <BERT.BARBE@oracle.com>, rmk@arm.linux.org.uk
Subject: Re: Re: 2.4.19 orinoco_cs with Lucent WaveLAN "bronze"
Date: Sun, 20 Oct 2002 14:35:19 -0200
X-Mailer: KMail [version 1.3.2]
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org
References: <3187992.1035061003952.JavaMail.nobody@web54.us.oracle.com>
In-Reply-To: <3187992.1035061003952.JavaMail.nobody@web54.us.oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 October 2002 18:56, Bert Barbe wrote:
> > On Sat, Oct 19, 2002 at 02:14:57PM +0000, Denis Vlasenko wrote:
> > > Today I played with wireless LAN euqipment for the first time.
> > > I have ISA-to-PCMCIA converter and a Lucent (IEEE) PCMCIA card.
> > > I set up everything as directed by HOWTOs. I do:
> >
> > Yes, I also noticed many problems with the current orinoco_cs
> > driver.
>
> I have an orinocco gold. In 2.4.x<19 it gave me some errors in the
> logs also, but despite that it seemed to work after setting the right
> options with iwconfig. I haven't tested 2.4.19 with the orinioco_cs
> driver yet since I had other problems with .19 before i got to that.

Can you be a bit more specific on that iwconfig options? ;-)

Also folks directed me to firmware upgrade, but it is for
Windows. Is there any for Linux? Did you upgrade yours?
--
vda
