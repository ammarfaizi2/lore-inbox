Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUI3BR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUI3BR4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 21:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUI3BRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 21:17:55 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:36489 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268090AbUI3BRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 21:17:46 -0400
To: Greg KH <greg@kroah.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <200409281919.Xvizfpbjxoiv0MeE@topspin.com>
	<200409281919.aKAVlO4yKkPzE7f0@topspin.com>
	<20040930001806.GA27400@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 29 Sep 2004 18:16:46 -0700
In-Reply-To: <20040930001806.GA27400@kroah.com> (Greg KH's message of "Wed,
 29 Sep 2004 17:18:06 -0700")
Message-ID: <524qlg369t.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][1/2] [take 2] kobject: add add_hotplug_env_var
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 30 Sep 2004 01:16:46.0418 (UTC) FILETIME=[275B5B20:01C4A68B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Cool.  Well the code in kobject.c has changed a lot recently
    Greg> (see the -mm tree) and the kernel-doc comments should be
    Greg> with the .c code, not the header file, so here's the version
    Greg> I committed to my trees.

Cool, looks good to me.

 - R.
