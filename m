Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbTF0U31 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 16:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbTF0U31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 16:29:27 -0400
Received: from mail.skjellin.no ([80.239.42.67]:18840 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S264769AbTF0U30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 16:29:26 -0400
Subject: Re: TCP send behaviour leads to cable modem woes
From: Andre Tomt <andre@tomt.net>
To: linux-kernel@vger.kernel.org
Cc: Svein Ove Aas <svein.ove@aas.no>
In-Reply-To: <200306272224.04335.svein.ove@aas.no>
References: <200306272020.57502.svein.ove@aas.no>
	 <3EFCA478.7010404@jpl.nasa.gov>  <200306272224.04335.svein.ove@aas.no>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1056746615.12886.459.camel@slurv.ws.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 27 Jun 2003 22:43:35 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On fre, 2003-06-27 at 22:24, Svein Ove Aas wrote:
> > http://lartc.org/wondershaper/
> 
> I wrote something like that myself once.
> It's a good shaper, but it works by *capping* up/download speeds and 
> rearranging the priorities locally, which wouldn't help me a bit.

By capping the speed below the link speed most modems will usually avoid
bursting. IMHO it's mostly a net gain in usability even though you don't
get the same raw download speeds as without capping.

-- 
Cheers,
André Tomt
andre@tomt.net

