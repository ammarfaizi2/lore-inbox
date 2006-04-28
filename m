Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWD1PWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWD1PWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWD1PWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:22:48 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:34246 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030428AbWD1PWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:22:48 -0400
Date: Fri, 28 Apr 2006 17:22:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Paulo Marques <pmarques@grupopie.com>
cc: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
In-Reply-To: <445220AB.9000606@grupopie.com>
Message-ID: <Pine.LNX.4.61.0604281721470.9011@yvahk01.tjqt.qr>
References: <20060427014141.06b88072.akpm@osdl.org> <p73vesv727b.fsf@bragg.suse.de>
 <20060427121930.2c3591e0.akpm@osdl.org> <200604272126.30683.ak@suse.de>
 <20060427124452.432ad80d.rdunlap@xenotime.net> <20060427131100.05970d65.akpm@osdl.org>
 <44512B61.4040000@google.com> <445220AB.9000606@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> and then set up the <command line> to use the serial console, and the initrd to
> something simple that just outputs "[SUCCESS]" and powers off.
>
Let it run for 5 minutes or so, to catch silly things like jiffy wraparound 
and bombs that go off a little later than kernel boot.


Jan Engelhardt
-- 
