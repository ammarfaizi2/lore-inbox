Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbWD0Otq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWD0Otq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 10:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbWD0Otq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 10:49:46 -0400
Received: from tresys.irides.com ([216.250.243.126]:63903 "EHLO
	exchange.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S965129AbWD0Otp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 10:49:45 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Karl MacMillan <kmacmillan@tresys.com>
To: casey@schaufler-ca.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060427002136.24536.qmail@web36603.mail.mud.yahoo.com>
References: <20060427002136.24536.qmail@web36603.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Apr 2006 10:47:43 -0400
Message-Id: <1146149263.2759.55.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 17:21 -0700, Casey Schaufler wrote:
> 
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > On Tue, 2006-04-25 at 20:42 -0700, Casey Schaufler
> > wrote:
> 
> > > Conflating my forehead!
> > 
> > The policy is analyzable, and there are tools (apol
> > and slat) that do precisely that.
> 
> Ok. I remain unconvinced, in part because the analysis
> requires tools.
> 

Not certain what you mean by requires - it is possible to do policy
analysis manually, though the tools certainly bring more rigor. Analysis
of SELinux policies is not simply possible in theory - it has been done
by us (Tresys) and others.

Karl

-- 
Karl MacMillan
Tresys Technology
www.tresys.com

> > Including information flow analysis
> > and invariant checking.
> 
> Ok. Fair enough.
> 
> > What's your problem, again?
> 
> You keep asking that.
> 
> I seem to have fallen off topic, which happens
> sometimes, and I apologize for falling into this
> long standing and overly religeous debate. I
> have failed to present my case with sufficient
> clarity to prove convincing once again. Perhaps
> one day I'll get it right. Perhaps one day I'll
> figure out why I'm wrong.
> 
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

