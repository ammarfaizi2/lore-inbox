Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269046AbUJFTAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269046AbUJFTAs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269341AbUJFTAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:00:47 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:17835 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S269046AbUJFTAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:00:40 -0400
Message-ID: <41644015.1070205@tampereentennisseura.net>
Date: Wed, 06 Oct 2004 21:57:25 +0300
From: Kari Hameenaho <khlaptop@tampereentennisseura.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
 >
 >* Lee Revell <rlrevell@xxxxxxxxxxx> wrote:
 >
 > > > i believe Andrew said that these USB problems should be fixed in
 > > > the next -mm iteration.
 > > >
 > >
 > > FWIW, this one does not work for me either, I get a USB-related Oops
 > > on boot.
 >
 > by next -mm iteration i meant -rc3-mm3, which is not released yet.
 >
 > Ingo
 >

The usb-hubs problem patch in LKML by Greg KH seems to fix this problem.

The thread is 2.6.9-rc3-mm1, bk-pci patch, USB hubs

---
Kari Hämeenaho
