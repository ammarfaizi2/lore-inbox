Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUKRRbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUKRRbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUKRR3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:29:31 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53779 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262803AbUKRR0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:26:09 -0500
To: Andi Kleen <ak@suse.de>
Cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <p73k6sj221d.fsf@brahms.suse.de>
	<E1CUjSB-0005II-00@mta1.cl.cam.ac.uk>
	<20041118132233.GG17532@wotan.suse.de>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 18 Nov 2004 09:26:00 -0800
In-Reply-To: <20041118132233.GG17532@wotan.suse.de> (Andi Kleen's message of
 "Thu, 18 Nov 2004 14:22:33 +0100")
Message-ID: <52vfc3kr13.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: Xen 2.0 VMM patches
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 18 Nov 2004 17:26:06.0552 (UTC) FILETIME=[AFBD4580:01C4CD93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> Overall I think it's a bad idea to have four different x86
    Andi> like architectures in the tree. Especially since there will
    Andi> be likely more hypervisors over time.  i386 and x86-64 make
    Andi> some sense because 64bit is a natural boundary, but
    Andi> extending it elsewhere doesn't scale very well.

Is there any possibility of Xen someday being ported to some non-x86
architecture (eg ppc64 or ia64)?

 - Roland
