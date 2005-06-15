Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVFOWyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVFOWyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFOWyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:54:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39049 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261626AbVFOWwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:52:42 -0400
Date: Wed, 15 Jun 2005 17:52:35 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Tom Lendacky <toml@us.ibm.com>,
       Greg KH <greg@kroah.com>, LSM <linux-security-module@wirex.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Emily Rattlif <emilyr@us.ibm.com>, Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <20050615225235.GC3492@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20050615215019.GB3660@serge.austin.ibm.com> <20050615220032.67977.qmail@web31612.mail.mud.yahoo.com> <20050615223832.GA3492@IBM-BWN8ZTBWA01.austin.ibm.com> <20050615224048.GS9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615224048.GS9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> > IIUC, another (separately implemented) module - whose
> > release I'm anxiously awaiting - will actually basically
> > be doing that...
> 
> At which point we can consider it for LSM inclusion, so let's wait until
> then, ok?

Absolutely, I just had to point that out cause it's kind of funny - as
though someone's out purely to "get something tcg-related into lsm"  :)


"Darnit, maybe if we just tweak this little bit to return -EPERM at 5am"


-serge

