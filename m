Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVBCOdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVBCOdy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbVBCObl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:31:41 -0500
Received: from serv4.servweb.de ([82.96.83.76]:22738 "EHLO serv4.servweb.de")
	by vger.kernel.org with ESMTP id S263865AbVBCO2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:28:43 -0500
Date: Thu, 3 Feb 2005 15:28:37 +0100
From: Patrick Plattes <patrick@erdbeere.net>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: security contact draft
Message-ID: <20050203142837.GA30981@erdbeere.net>
References: <20050113125503.C469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113125503.C469@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i think security mailing list is a good idea. normally i would prefere a
full open list, but in some cases this could be the right way.

i have an additional idea. maybe it is useful to push the mails on the
list into publc space automaticly after a delay of $NUMDAYS+$MAX -
according to alans idea. with this little feature we could be sure, that
no security report will be 'forgotten'.

this 'public space' could be an open security list where anyone else is
able to comment reports, fixes and bugs.

bye,
patrick

On Thu, Jan 13, 2005 at 12:55:03PM -0800, Chris Wright wrote:
> To keep the conversation concrete, here's a pretty rough stab at
> documenting the policy.
> 
>  Linux kernel developers take security very seriously.  As such, we'd
>  like to know when a security bug is found so that it can be fixed and
>  disclosed as quickly as possible.
> 
>  1) Contact
> 
>  The Linux kernel security contact is $CONTACTADDR.  This is a private
>  list of security officers who will help verify the bug report and develop
>  and release a fix.  It is possible that the security officers will bring
>  in extra help from area maintainers to understand and fix the security
>  vulnerability.
> 
>  It is preferred that mail sent to the security contact is encrypted
>  with $PUBKEY.
> 
>  As it is with any bug, the more information provided the easier it
>  will be to diagnose and fix.  Please review the procedure outlined in
>  REPORTING-BUGS if you are unclear about what information is helpful.
>  Any exploit code is very helpful and will not be released without
>  consent from the reporter unless it's already been made public.
> 
>  2) Disclosure
> 
>  The goal of the kernel security contact is to work with the bug submitter
>  to bug resolution as well as disclosure.  We prefer to fully disclose
>  the bug as soon as possible.  It is reasonable to delay disclosure when
>  the bug or the fix is not yet fully understood, the solution is not
>  well-tested or for vendor coordination.  However, we expect these delays
>  to be short, measurable in days, not weeks or months.  As a basic default
>  policy, we expect report to disclosure to be on the order of $NUMDAYS.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
