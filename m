Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUCWGnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 01:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUCWGnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 01:43:18 -0500
Received: from upco.es ([130.206.70.227]:46822 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262106AbUCWGnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 01:43:16 -0500
Date: Tue, 23 Mar 2004 07:43:10 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: swsusp 2.0 with kernel 2.6.4, failure to suspend (vaio fx701)
Message-ID: <20040323064310.GA6285@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	Patrick Mochel <mochel@osdl.org>
References: <20040322100521.GA26767@pern.dea.icai.upco.es> <1079990542.2770.25.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1079990542.2770.25.camel@calvin.wpcb.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 09:22:22AM +1200, Nigel Cunningham wrote:
> Hi.
> 
> Thanks for the report; The end of your log shows us that it was
> saslauthd that was causing the freezing failure. I'll look at what
> adjustments would fix that issue.

Ok.

> Regarding getting more debugging info, you need to use debug_sections as
> well as the default_console_level; the console level says how much
> information you want. debug_sections says what information you want.
> (Suspend it capable of printing an awful lot of debugging info; usually
> we're only interested in one particular area).

Darn, I missed it. Tell me which sections are of interest, and I can repeat
(this afternoon, if it's useful) and report. 

Thanks,
       Romano

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
