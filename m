Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWDQT0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWDQT0l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 15:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWDQT0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 15:26:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:20172 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751230AbWDQT0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 15:26:40 -0400
Date: Mon, 17 Apr 2006 14:26:34 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060417192634.GB18990@sergelap.austin.ibm.com>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com> <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Mon, 2006-04-17 at 11:02 -0700, Casey Schaufler wrote:
> > 
> > --- Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > > Or, better, remove LSM itself ;)
> > > 
> > > Seriously that makes a lot of sense.  All other
> > > modules people have come up
> > > with over the last years are irrelevant and/or
> > > broken by design.
> > 
> > Didn't you mean "Bah!" (waves paw)?
> > 
> > I understand the enthusiasm that the SELinux
> > following demonstrates for the technology.
> > I do not appreciate the bashing of alternatives.
> 
> Then provide a counterexample.

Hopefully a new version of evm+slim+ima will be ready for distribution
soon.

-serge
