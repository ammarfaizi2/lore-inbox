Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318221AbSHUQzK>; Wed, 21 Aug 2002 12:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSHUQzK>; Wed, 21 Aug 2002 12:55:10 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:2015 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318221AbSHUQzK>;
	Wed, 21 Aug 2002 12:55:10 -0400
Date: Wed, 21 Aug 2002 09:56:29 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: "Feldman, Scott" <scott.feldman@intel.com>,
       "'Troy Wilson'" <tcw@tempest.prismnet.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
       tcw@prismnet.com
Subject: Re: mdelay causes BUG, please use udelay
Message-ID: <2547745934.1029923788@[10.10.2.3]>
In-Reply-To: <3D63C3B1.328A872F@nortelnetworks.com>
References: <3D63C3B1.328A872F@nortelnetworks.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I currently work on an embedded device and if we detect given 
> network connection isn't working at all our first response is 
> to switch to a working connection, then we reload the device 
> driver for the non-working one.  Since we may be doing other 
> things at the same time, having this stall the machine for 
> extended periods of time is definately not a good thing.

That's great, IF you have a spare drop out to that net. 

M.

