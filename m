Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUDPMrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUDPMrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:47:05 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5504 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263084AbUDPMrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:47:01 -0400
Date: Fri, 16 Apr 2004 13:51:23 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200404161251.i3GCpNDq000170@81-2-122-30.bradfords.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10404160327060.22035-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10404160327060.22035-100000@master.linux-ide.org>
Subject: Re: SATA support merge in 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Andre Hedrick <andre@linux-ide.org>:
> 
> Since we are going over the cliff, lets get there faster!
> 
> Has 2.2 or 2.0 ever been audited for security issues, and fixed?
> 
> Whee this is fun!

I don't really see the relevence of what you're saying.

Maybe I wasn't clear when I said 'audited for security issues' - I meant
ensuring that fixes for 2.4 also eventually went in to 2.6.  I'm not talking
about doing any kind of complete audit of the entire codebase.

For a long time, (since before 2.6.0), there were known local root exploits
that had been fixed in 2.4 and not in 2.6.  I never saw those fixed, but I
don't have the details of them to hand, nor do I have the time to search
through years of mailing list archives at the moment.  However, I am also not
claiming that 2.6 is stable, (yet).

John.
