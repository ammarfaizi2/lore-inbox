Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUE0SJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUE0SJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUE0SJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:09:07 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:51861 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S264908AbUE0SJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:09:04 -0400
MBOX-Line: From george@galis.org  Thu May 27 14:09:03 2004
Date: Thu, 27 May 2004 14:09:03 -0400
From: George Georgalis <george@galis.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 problem, cd and hd on second ide channel
Message-ID: <20040527180903.GC13890@trot.local>
References: <20040527171325.GA13890@trot.local> <200405271945.38976.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405271945.38976.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.6i
Internet-Time: @797
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 07:45:38PM +0200, Bartlomiej Zolnierkiewicz wrote:
>
>There is ACPI bug in 2.6.6 related to IRQ routing.  Try 2.6.7-rc1.
>
>http://bugme.osdl.org/show_bug.cgi?id=2665


Thanks for the both the on list and off responses!

2.6.7-rc1 seems to work fine. :-)

Please respond if there is a compelling reason to use 2.6.5 instead.

Thanks again,

// George


-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

