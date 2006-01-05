Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWAENqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWAENqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWAENqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:46:53 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:48886 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751271AbWAENqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:46:52 -0500
Date: Thu, 5 Jan 2006 08:46:51 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Dave Jones <davej@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060105134651.GB4094@kurtwerks.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr> <20060105103339.GG20809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105103339.GG20809@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 05:33:39AM -0500, Dave Jones took 0 lines to write:
> 
> If I had any faith in the sturdyness of the floppy driver, I'd
> recommend someone looked into a 'dump oops to floppy' patch, but
> it too relies on a large part of the system being in a sane
> enough state to write blocks out to disk.

Not to mention that an increasing number of systems ship without a
floppy drive.

Kurt
-- 
If you perceive that there are four possible ways in which a procedure
can go wrong, and circumvent these, then a fifth way will promptly
develop.
