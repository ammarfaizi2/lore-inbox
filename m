Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbTAGAPM>; Mon, 6 Jan 2003 19:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTAGAPM>; Mon, 6 Jan 2003 19:15:12 -0500
Received: from pcp749571pcs.manass01.va.comcast.net ([68.49.125.82]:63361 "EHLO
	charon.int.bittwiddlers.com") by vger.kernel.org with ESMTP
	id <S267259AbTAGAPM>; Mon, 6 Jan 2003 19:15:12 -0500
Date: Mon, 6 Jan 2003 19:22:43 -0500
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI Support Is Improving Amazingly
Message-ID: <20030107002239.GA2141@bittwiddlers.com>
References: <1041898438.20314.7.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041898438.20314.7.camel@sbarn.net>
User-Agent: Mutt/1.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.65 (Johnstown)
Reply-To: Matthew Harrell 
	  <mharrell-dated-1042330964.e7b4d0@charon.int.bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I must say, in 2.5.54 I am *extremely* impressed by ACPI and how far it
> has excelled over APM. I used to never be able to have my computer
> automatically power off when I halted the system but now with ACPI it
> goes off! This is quite a trivial task too for this is an eMachine and
> imho it has a weird button setup period. Many thanks to the developers
> and maintainers of ACPI, keep up the good work.

That's funny since I was just cursing the ACPI code a little while ago.  
Beginning around 2.5.51 I have to boot with "acpi=off" to avoid having the
machine slow to a crawl and never actually finish booting up.  

-- 
  Matthew Harrell                          Failure is not an option. It comes
  Bit Twiddlers, Inc.                       bundled with your Microsoft
  mharrell@bittwiddlers.com                 product.
