Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268816AbUILTXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268816AbUILTXn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268812AbUILTXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:23:43 -0400
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:55964 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S268816AbUILTXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:23:40 -0400
Date: Sun, 12 Sep 2004 21:23:31 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Message-ID: <20040912192331.GB8436@hout.vanvergehaald.nl>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf> <1095008692.11736.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095008692.11736.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 06:04:53PM +0100, Alan Cox wrote:
> 
> This is not a TCP flaw, its a combination of poor design by certain
> vendors, poor BGP implementation and a lack of understanding of what TCP
> does and does not do. See IPSec. TCP gets stuff from A to B in order and
> knowing to a resonable degree what arrived. TCP does not proide a
> security service.
> 
> (The core of this problem arises because certain people treat TCP
> connection down on the peering session as link down)

Alan, could you please elaborate on this last statement?
I don't understand what you mean, and am very interested.

Thanks,
Toon.
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
