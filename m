Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVAUVnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVAUVnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVAUVl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:41:29 -0500
Received: from fsmlabs.com ([168.103.115.128]:62655 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262522AbVAUVjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:39:03 -0500
Date: Fri, 21 Jan 2005 14:38:36 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: George Anzinger <george@mvista.com>
cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
In-Reply-To: <41F16551.6090706@mvista.com>
Message-ID: <Pine.LNX.4.61.0501211429270.18199@montezuma.fsmlabs.com>
References: <20050119000556.GB14749@atomide.com>
 <Pine.LNX.4.61.0501192100060.3010@montezuma.fsmlabs.com>
 <20050121174831.GE14554@atomide.com> <Pine.LNX.4.61.0501211123260.18199@montezuma.fsmlabs.com>
 <41F16551.6090706@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello George,

On Fri, 21 Jan 2005, George Anzinger wrote:

> The VST patch on sourceforge
> (http://sourceforge.net/projects/high-res-timers/) uses the local apic timer
> to do the wake up.  This is the same timer that is used for the High Res work.

I've been meaning to look into it, although it's quite a bit of work going 
through all the extra code from the highres timer patch.

Thanks,
	Zwane

