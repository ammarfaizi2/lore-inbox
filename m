Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319722AbSIMRV4>; Fri, 13 Sep 2002 13:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319723AbSIMRV4>; Fri, 13 Sep 2002 13:21:56 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:61299 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S319722AbSIMRVz>; Fri, 13 Sep 2002 13:21:55 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE5E@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Soos Peter'" <sp@osb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: APM & ACPI detect
Date: Fri, 13 Sep 2002 10:26:35 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Soos Peter [mailto:sp@osb.hu] 
> On Thu, 12 Sep 2002, Grover, Andrew wrote:
> 
> > > Are there any "official way" to detect that APM or ACPI is active?
> > 
> > Well there's pm_active, which is 1 if either is on. Is this 
> really what you
> > want?
> 
> No, I have to know what stuff is active: APM or ACPI.

OK, I guess we'll add that.

-- Andy
