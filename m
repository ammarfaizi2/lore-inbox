Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbTF2XI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 19:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbTF2XI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 19:08:26 -0400
Received: from 12-226-168-214.client.attbi.com ([12.226.168.214]:54207 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP id S265040AbTF2XIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 19:08:25 -0400
Date: Sun, 29 Jun 2003 19:22:44 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Jeff Mock <jeff@mock.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.21 ICH5 SATA related hang during boot
Message-ID: <20030629232244.GB276@kurtwerks.com>
References: <5.1.0.14.2.20030629135412.03c1d940@mail.mock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030629135412.03c1d940@mail.mock.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Jeff Mock:
> 
> I'm running a 2.4.21 kernel on a redhat 9.0 system.
> 
> I'm having a problem when using serial ATA drives on an Intel 875P/ICH5
> motherboard where the kernel will hang at approximately the same place
> in the boot process about 25% of the time.

[tale of woe elided]

[lots of snippage]

> 1: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4363  Sat 
> Apr 19 17:46:46 PDT 2003

You won't get a lot of help here until you lose this module. 


> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 1919M
> agpgart: Unsupported Intel chipset (device id: 2578), you might want to try 
> agp_try_unsupported=1.
> agpgart: no supported devices found.
> 1: NVRM: AGPGART: unable to retrieve symbol table

Hmm.

Kurt
-- 
Very few profundities can be expressed in less than 80 characters.
