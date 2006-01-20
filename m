Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWATBQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWATBQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbWATBQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:16:43 -0500
Received: from [81.2.110.250] ([81.2.110.250]:33987 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030445AbWATBQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:16:42 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different
	approach
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dave Jones <davej@redhat.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
In-Reply-To: <1137711088.3241.9.camel@mindpipe>
References: <20060119174600.GT19398@stusta.de>
	 <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe>
	 <1137709135.8471.73.camel@localhost.localdomain>
	 <20060119224222.GW21663@redhat.com>  <1137711088.3241.9.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Jan 2006 01:13:47 +0000
Message-Id: <1137719627.8471.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 17:51 -0500, Lee Revell wrote:
> The status is we need someone who has the hardware who can add printk's
> to the driver to identify what triggers the hang.  It should not be
> hard, the OSS driver reportedly works.
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328
> 
> The bug has been in FEEDBACK state for a long time.

99.9% of users don't ever look in ALSA bugzilla. 

A dig shows

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=157371
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171221

