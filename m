Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbWASWVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWASWVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422675AbWASWVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:21:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28638 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422676AbWASWVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:21:20 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different
	approach
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz
In-Reply-To: <1137703413.32195.23.camel@mindpipe>
References: <20060119174600.GT19398@stusta.de>
	 <m3ek34vucz.fsf@defiant.localdomain>  <1137703413.32195.23.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 22:18:55 +0000
Message-Id: <1137709135.8471.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 15:43 -0500, Lee Revell wrote:
> Even the NeoMagic 256 which is a Pentium II era device and was in
> widespread use we cannot find a tester for.

There are plenty of neomagic audio users around, I've seen bug reports
about neomagic + ALSA hangs that have been filed.

