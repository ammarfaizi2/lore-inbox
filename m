Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSLHOSL>; Sun, 8 Dec 2002 09:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLHOSL>; Sun, 8 Dec 2002 09:18:11 -0500
Received: from m1.cs.man.ac.uk ([130.88.192.2]:11021 "EHLO m1.cs.man.ac.uk")
	by vger.kernel.org with ESMTP id <S261292AbSLHOSK>;
	Sun, 8 Dec 2002 09:18:10 -0500
Date: Sun, 8 Dec 2002 14:25:45 +0000 (GMT)
From: Simon Ward <simon.ward@cs.man.ac.uk>
X-X-Sender: wards0@tl019.cs.man.ac.uk
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: PROBLEM: Oops.. NULL pointer reference in 2.4.20-ac1
In-Reply-To: <1039357173.6912.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0212081355040.14363-100000@tl019.cs.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Dec 2002, Alan Cox wrote:

> Looks like your system returned a totally bogus IRQ for the interface.
> Are you enabling ACPI by any chance ?

No, I specifically disable ACPI because it doesn't work properly on the
system even though it claims to support it.

Simon (please CC to <simon.ward@cs.man.ac.uk>)
-- 
Email: simon.ward@cs.man.ac.uk -- ICQ UIN: 63202593
Your analyst has you mixed up with another patient.  Don't believe a
thing he tells you.

