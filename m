Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319612AbSIMLzX>; Fri, 13 Sep 2002 07:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319614AbSIMLzX>; Fri, 13 Sep 2002 07:55:23 -0400
Received: from firewall.osb.hu ([193.224.234.1]:65289 "EHLO firewall")
	by vger.kernel.org with ESMTP id <S319612AbSIMLzW>;
	Fri, 13 Sep 2002 07:55:22 -0400
Date: Fri, 13 Sep 2002 13:54:09 +0200 (CEST)
From: Soos Peter <sp@osb.hu>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: APM & ACPI detect
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE4E@orsmsx119.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0209131351010.1953-100000@sppc.intranet.osb.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Grover, Andrew wrote:

> > Are there any "official way" to detect that APM or ACPI is active?
> 
> Well there's pm_active, which is 1 if either is on. Is this really what you
> want?

No, I have to know what stuff is active: APM or ACPI.

Thanks,
Peter



