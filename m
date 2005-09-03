Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbVICBuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbVICBuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 21:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVICBuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 21:50:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50383 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751355AbVICBuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 21:50:39 -0400
Date: Fri, 2 Sep 2005 19:35:13 -0500
From: serue@us.ibm.com
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>
Subject: Re: [PATCH] 2.6.13: Filesystem capabilities 0.16
Message-ID: <20050903003513.GA15764@sergelap.austin.ibm.com>
References: <87ll2ghb95.fsf@goat.bogus.local> <87fysnmvj6.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fysnmvj6.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or, has there been any communication between yourself and
Nicholas Hans Simmonds, who posted his xattr-based fscaps
patch in july (first posting july 2)?

thanks,
-serge

Quoting Nix (nix@esperi.org.uk):
> On 1 Sep 2005, Olaf Dietsche murmured woefully:
> > This patch implements filesystem capabilities. It allows to run
> > privileged executables without the need for suid root.
> 
> Is there some reason why this doesn't keep its capability data in
> xattrs?
> 
> -- 
> `... published last year in a limited edition... In one of the
>  great tragedies of publishing, it was not a limited enough edition
>  and so I have read it.' --- James Nicoll
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
