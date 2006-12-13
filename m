Return-Path: <linux-kernel-owner+w=401wt.eu-S964998AbWLMPSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWLMPSb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 10:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWLMPSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 10:18:31 -0500
Received: from www.osadl.org ([213.239.205.134]:39068 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964998AbWLMPSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 10:18:30 -0500
X-Greylist: delayed 1896 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 10:18:30 EST
Subject: Re: + high-res-timers-utilize-tsc-clocksource-again.patch added to
	-mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <1165941969.8103.56.camel@imap.mvista.com>
References: <200612010114.kB11EvV3027260@shell0.pdx.osdl.net>
	 <1165941969.8103.56.camel@imap.mvista.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 15:50:36 +0100
Message-Id: <1166021436.24604.383.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 08:46 -0800, Daniel Walker wrote:
> What is this accomplishing? My TSC gets marked unstable, and it's not
> unstable, in addition I have HRT off .. The else clause above just
> doesn't seem right ..

This was a mismerge. It's fixed by now.

Thanks,

	tglx




