Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSHHAau>; Wed, 7 Aug 2002 20:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSHHAat>; Wed, 7 Aug 2002 20:30:49 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:63431 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S317078AbSHHAat>; Wed, 7 Aug 2002 20:30:49 -0400
Message-ID: <3D51BC64.4030704@snapgear.com>
Date: Thu, 08 Aug 2002 10:33:40 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Amol Lad <dal_loma@yahoo.com>
Subject: Re: uclinux on MMU platforms - query
References: <3D50B42B.8000200@snapgear.com> <1028719830.18156.238.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Alan Cox wrote:
> On Wed, 2002-08-07 at 06:46, Greg Ungerer wrote:
> 
>> >  Can I run uClinux on platforms that has MMU
>>
>>You could, but why would you want to?
> 
> 
> Being able to run true ucLinux on i386 makes debugging and verification
> of software so much less painful sometimes. 

For some things yes. But it is a real pain trying to track
down memory corruption and stack overflow problems in
applications. They have a tendency to take your the whole system...

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

