Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTKAWiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 17:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTKAWiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 17:38:25 -0500
Received: from baloney.puettmann.net ([194.97.54.34]:58778 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S261190AbTKAWiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 17:38:24 -0500
To: linux-kernel@vger.kernel.org
CC: Ricardo Galli <gallir@uib.es>
From: Ruben Puettmann <ruben@puettmann.net>
Subject: Re: Synaptics losing sync
In-Reply-To: <N7gI.1K3.9@gated-at.bofh.it>
References: <N7gI.1K3.9@gated-at.bofh.it>
Reply-To: ruben@puettmann.net
Date: Sat, 1 Nov 2003 23:37:39 +0100
Message-Id: <E1AG4NH-0006xZ-00@baloney.puettmann.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote  in linux.kernel:
> I've sent this report before. 
>
> I repeat it just in case someone found a workaround, and because 
> 2.6.0-test9 gives other related errors as well (TSC error):
>
> ...
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 4th byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 1st byte
> Synaptics driver resynced.
> Losing too many ticks!
> TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> Falling back to a sane timesource.
> Synaptics driver lost sync at 1st byte
> ...
>
> The laptop is a Dell X200 with APM and cpufreq enabled, and IO-apic 
> disabled.
>
Here the same with IBM Thinkpad R40 2722GDG with APM cause ACPI is for
this laptop totaly broken.

                Ruben


-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
