Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313565AbSDQLck>; Wed, 17 Apr 2002 07:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313566AbSDQLcj>; Wed, 17 Apr 2002 07:32:39 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8709 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313565AbSDQLci>; Wed, 17 Apr 2002 07:32:38 -0400
Message-Id: <200204171128.g3HBS5X29316@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: traditional bug: only one of two serial ports found on HP Vectra XM
Date: Wed, 17 Apr 2002 14:30:16 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3CBD382B.20432.3A9A82@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 April 2002 04:54, Ulrich Windl wrote:
> historically I believed Linux very much. When it said my HP Vecra XM
> only has one serial port I was surprised, but believed it. That was
> some years ago. 2.4.18 still says that there is one serial port:
>
> ttyS00 at 0x3f8 (irq=4) as a 16550A
>
> However recently I had to work on the backside of the PC and found
> two(!) serial ports labelled "Serial A" and "Serial B". So shouldn't
> both ports be detected?

How about opening the case and checking whether those ports actually
connected to motherboard? Checking BIOS config?
Without waiting for another 'some years' :-)

Seriously, do you have any reason to think second port is really
exists beside physical connector?
--
vda
