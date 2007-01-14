Return-Path: <linux-kernel-owner+w=401wt.eu-S1750846AbXANAfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbXANAfq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 19:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbXANAfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 19:35:46 -0500
Received: from gw.goop.org ([64.81.55.164]:39106 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbXANAfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 19:35:45 -0500
Message-ID: <45A97ADC.7010700@goop.org>
Date: Sat, 13 Jan 2007 16:35:40 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 16/20] XEN-paravirt: Add the Xen virtual console driver.
References: <20070113014539.408244126@goop.org>	<20070113014648.767777869@goop.org> <20070114003752.27a5cac4@localhost.localdomain>
In-Reply-To: <20070114003752.27a5cac4@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Andrew: No objection to this tty stuff being merged provided the bugs
> noted above (not worried about the sign stuff) are fixed before it goes
> on to Linus.
>   

Thanks for the comments.  I'll see if I can put together a fixup patch
before LCA, but possibly not.

    J
