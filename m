Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311050AbSCMTXt>; Wed, 13 Mar 2002 14:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311059AbSCMTXk>; Wed, 13 Mar 2002 14:23:40 -0500
Received: from magic.adaptec.com ([208.236.45.80]:4234 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id <S311050AbSCMTXQ>;
	Wed, 13 Mar 2002 14:23:16 -0500
Message-ID: <F8D30FF32B23D61198B9009027D61DB32FC217@otcexc01.otc.adaptec.com>
From: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>
To: "'Adam J. Richter'" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: RE: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet w
	orking)
Date: Wed, 13 Mar 2002 14:23:16 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Adam J. Richter [mailto:adam@yggdrasil.com]
> 		o dpt_i2o - I need to understand the i2o system a little
more
> 		  to determine whether all of the similar looking code in
> 		  drivers/messages/i2o and dpt_i2o is redundant or
necessary.
> 

This code is very similar to the i2o subsystem, yet it is not the same.
When I get free of my current project I will work on updating this module
(unless someone beats me to it).

Deanna
