Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282926AbRK0UJ2>; Tue, 27 Nov 2001 15:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282928AbRK0UJT>; Tue, 27 Nov 2001 15:09:19 -0500
Received: from sr1.terra.com.br ([200.176.3.16]:27520 "EHLO sr1.terra.com.br")
	by vger.kernel.org with ESMTP id <S282926AbRK0UJD>;
	Tue, 27 Nov 2001 15:09:03 -0500
Message-ID: <3C03F2DC.30706@terra.com.br>
Date: Tue, 27 Nov 2001 18:09:00 -0200
From: Piter Punk <piterpk@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Absence of PS/2 keyboard causes spurious IRQ7? - Was Re:  'spurious 8259A interrupt: IRQ7'
In-Reply-To: <1793.10.119.8.1.1006872608.squirrel@extranet.jtrix.com> <5.1.0.14.2.20011127193412.00acb450@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

> Also when using the USB keyboard I get keyboard: Timeout - AT keyboard 
> not present?(f4) messages popping up from time to time. Usually 
> accompanied by a spurious IRQ7 message.
> 
> So at least on my VIA box there seems to be a relationship between the 
> lack of PS/2 keyboard and the IRQ7 messages.
> 
> Note, with my PS/2 keyboard (before I upgraded to USB one) I never saw 
> either of the above messages.

Hi... i have (@work) a Duron with VIA82C686A and a PS/2 keyboard connected

see the same error message "blablabla spurious irq7". I think the problem is 
independent have or not the keyboard connected...


-- 
   ____________
  / Piter PUNK \_____________________________________________________
|                                                                   |
|      |        E-Mail: piterpk@terra.com.br         (personal)     |
|     .|.               roberto.freires@gds-corp.com (professional) |
|     /V\                                                           |
|    // \\      UIN: 116043354  Homepage: www.piterpunk.hpg.com.br  |
|   /(   )\                                                         |
|    ^`~'^         ----> Slackware Linux - The Best One! <----      |
|   #105432                                                         |
`-------------------------------------------------------------------'

