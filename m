Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSJYXHP>; Fri, 25 Oct 2002 19:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261650AbSJYXHP>; Fri, 25 Oct 2002 19:07:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20727 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261646AbSJYXHO>;
	Fri, 25 Oct 2002 19:07:14 -0400
Message-ID: <3DB9D004.7041A75E@mvista.com>
Date: Fri, 25 Oct 2002 16:13:08 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ACPI in the box CONFIG
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to define something like:

CONFIG_HAS_ACPI

in the Config.in file, dependent on the hardware.  It could
then be used to allow ACPI support to be prompted for or
not.

So, does any one know which of the boxen listed in the
Config.in (../arch/i386/Config.in) have the required
hardware?
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
