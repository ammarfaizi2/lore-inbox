Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbTF1UlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265434AbTF1UlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:41:08 -0400
Received: from mail.webmaster.com ([216.152.64.131]:38322 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265405AbTF1Uk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:40:58 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: bkbits.net is down
Date: Sat, 28 Jun 2003 13:55:11 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEAJEAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <1056832290.6289.44.camel@dhcp22.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sad, 2003-06-28 at 20:38, Dr. David Alan Gilbert wrote:

> > Tapes are a pain; but at the type of 40GB range is it worth considering
> > a pile of external USB/Firewire hard drives?

> I'm testing the USB2 disk idea at the moment. Big problem is performance
> - 5Mbytes/second isnt the best backup rate in the world.

	If the issue is the time the backup itself takes, 2 hours isn't a big deal,
it'll finish over a long lunch break. If the issue is having to lock out
write access or otherwise stabilize the actual data for the time it takes to
backup, just stage a copy of the backup to a local disk and then backup to
external disk from there.

	DS


