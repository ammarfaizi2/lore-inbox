Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTICJjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTICJjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:39:03 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:3209 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S261785AbTICJi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:38:59 -0400
Date: Wed, 3 Sep 2003 11:38:08 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Where do I send APIC victims?
Message-ID: <20030903093808.GA28594@k3.hellgate.ch>
Mail-Followup-To: Andrew de Quincey <adq_dvb@lidskialf.net>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20030903080852.GA27649@k3.hellgate.ch> <200309031123.58713.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309031123.58713.adq_dvb@lidskialf.net>
X-Operating-System: Linux 2.6.0-test4 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003 11:23:58 +0100, Andrew de Quincey wrote:
> Hi, I'm trying to develop patches for ACPI IRQ issues. 

That would be most appreciated.

> Are these VIA KT333/KT400 chipsets? If so, there's a known bug in many BIOSes 

Yes, at least some of them are. I often don't know, since the reports just
say "Rhine ethernet broke in the new kernel" (VIA based boards typically
come with Rhine ethernet integrated into the south bridge).

> with these chipsets. I'm waiting on some docs from VIA to fix this issue.

Which still leaves the question of why it used to work (or made the
impression it did) with older kernels.

Roger
