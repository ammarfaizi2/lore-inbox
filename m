Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTDRKyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 06:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbTDRKyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 06:54:06 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27404 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263015AbTDRKyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 06:54:05 -0400
Date: Fri, 18 Apr 2003 07:01:06 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: DigorA <ydigora@yandex.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: /target0/lun0/
In-Reply-To: <3E9E93F3.000007.06385@camay.yandex.ru>
Message-ID: <Pine.LNX.3.96.1030418065929.8516B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003, DigorA wrote:

> Waiting for your help!
> 
> After successfull update of a new kernel from 2.2.14 to 2.4.18 first
> rebooting did failed.  On the stage of initialisation (but before
> inittab) had wrote "Partition check: /dev/ide/host0/bus0/target0/lun0"
> and buzzed.  Booting from rescue disk with differnet kernel (some disks
> with kernel 2.4.x does work, some doesn't) enables disk.  But I'm
> resctricted with usage and long booting and differnet kernel and so on. 
> So hard disk works through other kernel.  What can be done? 

Using devfs? That sounds vaguely like a message which might come out of a
devfs botch of some kind. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

