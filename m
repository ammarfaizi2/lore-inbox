Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261437AbSJABfo>; Mon, 30 Sep 2002 21:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbSJABfl>; Mon, 30 Sep 2002 21:35:41 -0400
Received: from mnh-1-19.mv.com ([207.22.10.51]:44038 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261437AbSJABfk>;
	Mon, 30 Sep 2002 21:35:40 -0400
Message-Id: <200210010243.VAA05442@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrew Morton <akpm@digeo.com>
cc: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] 2.5.39 - might_sleep() exception - ACPI/APIC, UML compile issues on MP 2000+ 
In-Reply-To: Your message of "Sat, 28 Sep 2002 01:49:10 MST."
             <3D956D06.D7370490@digeo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Sep 2002 21:43:34 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@digeo.com said:
> It's strange that this ever worked.  Does this fix? 

Yes it does, but it is better to extract the definition from the ifdefs that
I blindly copied from i386.

				Jeff

