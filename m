Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUBODxn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 22:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUBODxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 22:53:43 -0500
Received: from atari.saturn5.com ([209.237.231.200]:17068 "HELO
	atari.saturn5.com") by vger.kernel.org with SMTP id S263898AbUBODxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 22:53:42 -0500
Date: Sat, 14 Feb 2004 19:53:41 -0800
From: Steve Simitzis <steve@saturn5.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Feldman, Scott" <scott.feldman@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: e1000 problems in 2.6.x
Message-ID: <20040215035341.GF1040@saturn5.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229F6F@orsmsx402.jf.intel.com> <20040215023226.GE1040@saturn5.com> <402EE603.8020106@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402EE603.8020106@tmr.com>
User-Agent: Mutt/1.3.28i
X-gestalt: heart, barbed wire
X-Cat: calico
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/04, Bill Davidsen <davidsen@tmr.com> wrote: 

> 1 - check your cables in case 2.6 is checking (or not) something
> 2 - set your NIC half to match the switch and see if there's a different 
> problem.

rebooting to 2.4.22 results in a perfectly working network connection,
even with auto-negotiate on both the card and the switch. so i am
hestitant to blame the cables or the hardware. unless, of course, my
cables have the ability to detect which OS i'm running. :)

the result is 100% predictable: boot to 2.6.x, network problems. change
the settings on the device or the switch - network problems. boot
back to 2.4.22 with auto-negotiate everywhere, perfect connection. alas.

-- 

steve simitzis : /sim' - i - jees/
          pala : saturn5 productions
 www.steve.org : 415.282.9979
  hath the daemon spawn no fire?

