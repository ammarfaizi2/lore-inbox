Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbRFGSc7>; Thu, 7 Jun 2001 14:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbRFGSct>; Thu, 7 Jun 2001 14:32:49 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:5315 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S262747AbRFGScj>;
	Thu, 7 Jun 2001 14:32:39 -0400
Message-ID: <3B1FC8E1.262586C0@fc.hp.com>
Date: Thu, 07 Jun 2001 12:33:05 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de> <3B1FAF79.DF86DA0A@fc.hp.com> <3B1FC660.D958CB6C@pcsystems.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:
> There is in fact no terminator, the scsi disc should terminate the bus
> itself. It is directly connected to the onboard aix7880 scsi controller.
> I will use another cable in about half an hour (when my friend arrives..)
> 
> Thanks for the hint!
> 
> Nico
> 

I would suggest checking "Term Enable" jumper on the disk just to be
sure. This jumper needs to be on for most (I would think all) drives to
terminate the bus.

--
Khalid
 
====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
