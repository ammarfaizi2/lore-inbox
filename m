Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264271AbUFCUmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUFCUmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUFCUmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:42:32 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:46008 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S264271AbUFCUma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:42:30 -0400
Date: Thu, 3 Jun 2004 22:41:47 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Nathan Straz <nstraz@sgi.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Stock IA64 kernel on SGI Altix 350
Message-ID: <20040603204147.GB27701@fi.muni.cz>
References: <20040603170147.GK10708@fi.muni.cz> <200406031030.36181.jbarnes@engr.sgi.com> <20040603200905.GA27701@fi.muni.cz> <200406031319.06466.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406031319.06466.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
: Cool, but keep in mind that this is totally unsupported.  If this kernel 
: breaks, you get to keep both pieces

	Yes, of course.

: (though I'll try to help glue it back 
: together!) :)
: 
	Thanks.

: I think 'make help' documents most of it.

	OK.
: 
: These messages are consistent with having a PROM that's too old; you need at 
: least 3.32.  You'll have to dig around the support site some more or talk to 
: your support person for that though.
: 
	3.25 is the latest released (or at least the latest I can find).
I will ask local support.

:  Booting with 'nohalt' should work 
: around this particular issue though.

	Yes. It works now, I have 2.6.7-rc2-mm2 up and running. Thanks again.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
++> I consider none of the code I contributed to glibc (which is quite a <++
++> lot) to be as part of the GNU project.             -- Ulrich Drepper <++
