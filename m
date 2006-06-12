Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752095AbWFLP6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbWFLP6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbWFLP6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:58:03 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:7378 "EHLO
	pih-relay04.plus.net") by vger.kernel.org with ESMTP
	id S1752095AbWFLP6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:58:02 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PS/2 vs IDE problem on Athlon64 X2
Date: Mon, 12 Jun 2006 16:57:01 +0100
User-Agent: KMail/1.9.3
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
References: <20060612074437.0690014018@rhn.tartu-labor> <200606121201.57708.rjw@sisk.pl>
In-Reply-To: <200606121201.57708.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121657.01555.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 11:01, Rafael J. Wysocki wrote:
> On Monday 12 June 2006 09:44, Meelis Roos wrote:
> > RJW> I have a machnine with Athlon64 X2 and AsRock 939Dual-SATA2 mobo
> > (based RJW> on the ULI chipset) on which the PS/2 devices (keyboard and
> > mouse) are in a RJW> bad correlation with IDE, or at least with the
> > LiteOn DVD burner attached to it.
> >
> > I recently got the same mainboard and it works fine for me with CD
> > reading/writing (LG CDRW, no DVD drive). Just tried yesterday, wrote a
> > CD at speed 12 and then read it as fast as it could and I did not notice
> > anything wrong. I'm using PS/2 keyboard and mouse and a very recent git
> > kernel (2.6.17-rc6+...). Maybe the CD speed is not enough to trigger it.
>
> That would probably mean there's a hardware problem with my mobo.  Well ...

This problem certainly sounds like a hardware fault. If you're not using the 
latest BIOS for this board, I suggest you upgrade it.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
