Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWJ1EW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWJ1EW5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 00:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWJ1EW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 00:22:57 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:52384 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1751768AbWJ1EW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 00:22:56 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: AMD X2 unsynced TSC fix?
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Andi Kleen <ak@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <200610272106.13115.ak@suse.de>
References: <1161969308.27225.120.camel@mindpipe>
	 <1161986902.27225.206.camel@mindpipe>
	 <1162007907.26022.13.camel@localhost.localdomain>
	 <200610272106.13115.ak@suse.de>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 05:22:53 +0100
Message-Id: <1162009373.26022.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 21:06 -0700, Andi Kleen wrote:
> > So far, has I can understand. Seems to me that my computer which have a
> > Pentium D (Dual Core) on VIA chipset, also have unsynchronized TSC and
> > with the patch of hrtimers on
> 
> Intel systems (except for some large highend systems) have synchronized TSCs. 
> Only exception so far seems to be a few systems that are 
> overclocked/overvolted and running outside their specification. 
> When you do that you'e on your own and we're not interested in a bug
> report.

and my computer :) 
http://www.asrock.com/product/775Dual-880Pro.htm
http://www.asrock.com/support/CPU_Support/show.asp?Model=775Dual-880Pro
Monday I will checkout if my computer is under specs. 
Seems that I like buy computers with many problems on Linux and fix :)

> There was also one BIOS found that had this problem, but it was old and rare
> and got fixed with a upgrade.
> 
> > Just to point out. This could be more a problem of chipsets than CPUs
> > (AMD or Intel). AMD just begin first using x86_64 archs :)
> 
> No.
> 
> -Andi

