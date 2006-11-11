Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754886AbWKKWk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbWKKWk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 17:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbWKKWk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 17:40:27 -0500
Received: from mail1.coralwave.com ([24.244.175.138]:40975 "EHLO
	mail1.coralwave.com") by vger.kernel.org with ESMTP
	id S1754886AbWKKWk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 17:40:26 -0500
From: Jason Harrison <jharrison@linuxbs.org>
To: Steve Langasek <vorlon@debian.org>
Subject: Re: [patch] video: support for VGA hoses on alpha TITAN, TSUNAMI systems (ES45, DS25)
Date: Sat, 11 Nov 2006 17:40:16 -0500
User-Agent: KMail/1.9.5
References: <20061102083718.GC12267@mauritius.dodds.net> <200611082104.37349.jharrison@linuxbs.org> <20061109055510.GH5314@mauritius.dodds.net>
In-Reply-To: <20061109055510.GH5314@mauritius.dodds.net>
Cc: Eki <eki@sci.fi>, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org, thias.lelourd@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111740.17003.jharrison@linuxbs.org>
X-IMAIL-SPAM-DNSBL: (v6net,514313bf02441ffa,65.77.130.111)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I patched the kernel with the extra systype patch located at this link.

http://www.vipu.org/~eki/alpha-titan-systype.patch

Now the kernel seems to compile fine.  By the way I am compiling a kernel 
specifically for titan type systems.  Not a generic alpha kernel.  I know eki 
had given me links to 2 patches before.  For some reason I thought they were 
both incorporated into the alpha-titan-video.patch you were working on.  I 
hope this information helps.  Not sure why the second patch is needed.  Good 
to know though.

Regards,
Jason
