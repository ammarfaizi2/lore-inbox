Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVCNWpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVCNWpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVCNWmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:42:43 -0500
Received: from isilmar.linta.de ([213.239.214.66]:41162 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262026AbVCNWjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:39:46 -0500
Date: Mon, 14 Mar 2005 23:39:45 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: Jan De Luyck <lkml@kcore.org>, davej@redhat.com,
       cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: cpufreq on-demand governor up_treshold?
Message-ID: <20050314223945.GC13378@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Eric Piel <Eric.Piel@tremplin-utc.net>,
	Jan De Luyck <lkml@kcore.org>, davej@redhat.com,
	cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
References: <200503140829.04750.lkml@kcore.org> <42354400.7070500@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42354400.7070500@tremplin-utc.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 08:57:52AM +0100, Eric Piel wrote:
> BTW, DaveJ, Dominik, I couldn't find them in the daily-snapshot 
> available at codemonkey.org.uk. Should I worry, or is it just due to 
> some latency between your private trees and the public one?

/me has no official position wrt cpufreq core [except userspace
cpufrequtils, but I intend to hand this over to somebody else in the next
few months].

Dave, as maintainer of cpufreq, has a cpufreq bitkeeper tree [http interface
at http://linux-dj.bkbits.net/ ] which is exported as plain diff daily at
http://www.codemonkey.org.uk/projects/cpufreq/daily-snapshots/ . This does
not contain your patches yet, probably because he's still busy with other
stuff.

Thanks,
	Dominik
