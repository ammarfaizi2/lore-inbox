Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSIFMdg>; Fri, 6 Sep 2002 08:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318542AbSIFMdg>; Fri, 6 Sep 2002 08:33:36 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:40199 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S316856AbSIFMdg>;
	Fri, 6 Sep 2002 08:33:36 -0400
Subject: Re: virtual ethernet adapter?
From: Shaya Potter <spotter@cs.columbia.edu>
To: Peter Svensson <petersv@psv.nu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209060806490.1994-100000@cheetah.psv.nu>
References: <Pine.LNX.4.44.0209060806490.1994-100000@cheetah.psv.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Sep 2002 08:34:57 -0400
Message-Id: <1031315698.28301.12.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from what I can tell, tap just lets a programs use it, but one needs a
user space app behind it (reading and writing to it).  It doesn't seem
to have the ability to live on the network like vmware's vmnet stuff
does, perhaps I'm wrong and was confused by the web page.

On Fri, 2002-09-06 at 02:07, Peter Svensson wrote:
> On 5 Sep 2002, Shaya Potter wrote:
> 
> > Is there any open code that is similiar to what vmware provides that
> > enables one to create virtual ethernet adapters?  I've seen the tap
> > device, but that's not what I need.
> 
> In what way is it not what you need? What do you need? 
> 
> Peter
> --
> Peter Svensson      ! Pgp key available by finger, fingerprint:
> <petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
> ------------------------------------------------------------------------
> Remember, Luke, your source will be with you... always...
> 


