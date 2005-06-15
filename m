Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVFOWlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVFOWlc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVFOWlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:41:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57835 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261602AbVFOWlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:41:02 -0400
Date: Wed, 15 Jun 2005 15:40:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Chris Wright <chrisw@osdl.org>,
       Tom Lendacky <toml@us.ibm.com>, Greg KH <greg@kroah.com>,
       LSM <linux-security-module@wirex.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Emily Rattlif <emilyr@us.ibm.com>, Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <20050615224048.GS9046@shell0.pdx.osdl.net>
References: <20050615215019.GB3660@serge.austin.ibm.com> <20050615220032.67977.qmail@web31612.mail.mud.yahoo.com> <20050615223832.GA3492@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615223832.GA3492@IBM-BWN8ZTBWA01.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> Quoting Casey Schaufler (casey@schaufler-ca.com):
> > You could, of course, add code to act on the
> > integrity measurements you've made, in which
> > case you could be in conformance with the
> > stated eligibilty requirements.
> 
> :)
> 
> IIUC, another (separately implemented) module - whose
> release I'm anxiously awaiting - will actually basically
> be doing that...

At which point we can consider it for LSM inclusion, so let's wait until
then, ok?

thanks,
-chris
