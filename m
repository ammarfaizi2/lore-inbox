Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSEXSMK>; Fri, 24 May 2002 14:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317235AbSEXSMJ>; Fri, 24 May 2002 14:12:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56231 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314680AbSEXSMI>;
	Fri, 24 May 2002 14:12:08 -0400
Date: Fri, 24 May 2002 11:10:49 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Austin Gonyou <austin@digitalroadkill.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <435570000.1022263849@flay>
In-Reply-To: <1022263434.9591.60.camel@UberGeek>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, adjusting the bdflush parms greatly increases stability I've found
> in this respect.

What exactly did you do to them? Can you specify what you're set to
at the moment (and anything you found along the way in tuning)?

> Problem is, my tests are *unofficial* but I plan to do something perhaps
> at OSDL and see what we can show in a max single-box config with real
> hardware, etc. 

Great stuff, I'm very interested in knowing about any problems you find.
We're doing very similar things here, anywhere from 8-32 procs, and
4-32Gb of RAM, both NUMA and SMP.

Thanks,

Martin.

