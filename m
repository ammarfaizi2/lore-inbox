Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317860AbSHDPNR>; Sun, 4 Aug 2002 11:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSHDPNQ>; Sun, 4 Aug 2002 11:13:16 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:54439 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S317860AbSHDPNQ>; Sun, 4 Aug 2002 11:13:16 -0400
Message-ID: <3D4D4544.4045B5D3@ntlworld.com>
Date: Sun, 04 Aug 2002 16:16:20 +0100
From: alien.ant@ntlworld.com
X-Mailer: Mozilla 4.7 [en-gb] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 IDE Partition Check issue
References: <20020804054239.62923.qmail@web9203.mail.yahoo.com> <1028470037.14195.24.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
 
> On Sun, 2002-08-04 at 06:42, Alex Davis wrote:
> > What is UDMA44????
>
> There are several actual speed steppings other than UDMA 33/66. The
> 33/66 are the top end for the control/cable. The drive may actually
> choose a speed in between

I actually forced it to UDMA 44 as there were issues with the IBM drive
and the highpoint controller at one time (they may have been resolved
now but I have no need to increase to 66 - and wonder if in fact there
is any benefit in doing so, anyway).

Alan - I'm wondering if this issue is related to Maxtor drives? All the
reports I have seen of this problem have featured drives from this
manufacturer.
