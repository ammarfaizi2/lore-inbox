Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTEMTP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTEMTP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:15:28 -0400
Received: from port-212-202-172-137.reverse.qdsl-home.de ([212.202.172.137]:40851
	"EHLO jackson.localnet") by vger.kernel.org with ESMTP
	id S263481AbTEMTPY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:15:24 -0400
Date: Tue, 13 May 2003 21:31:12 +0200 (CEST)
Message-Id: <20030513.213112.184808431.rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: APIC error
From: Rene Rebe <rene.rebe@gmx.net>
X-Mailer: Mew version 3.1 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19FfUj-0008Mx-LG*oE8CowmEV4U*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on a dual Pentium-mmx 233Mhz box (I got for free ...) I get many APIC
errors, like:

APIC error on CPU1: 08(00)
APIC error on CPU0: 02(00)
... ...

I also sometimes got 04(00).

Those errors only seem to happen during high disk-io (SCSI or IDE).
What specific meaning do those errors have? Are they dangerous?

Each CPU survives hours in memtest86 ... And with maxcpus=1 it also
does not seem to happen ... The BIOS is latest.

Sincerely,
  René Rebe

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene.rebe@gmx.net
http://www.rocklinux.org http://www.rocklinux.org/people/rene       
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene
