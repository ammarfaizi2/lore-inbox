Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVC3Xat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVC3Xat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVC3Xat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:30:49 -0500
Received: from eth2613.sa.adsl.internode.on.net ([150.101.239.52]:47837 "EHLO
	mail.oasissystems.com.au") by vger.kernel.org with ESMTP
	id S262533AbVC3Xae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:30:34 -0500
Date: Thu, 31 Mar 2005 09:00:29 +0930
From: John Pearson <jpearson@oasissystems.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050330233029.GA28879@sa.pracom.com.au>
References: <Pine.LNX.4.61.0503290659360.10929@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503290659360.10929@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: -105.8
X-Spam-Report: Spam detection software, running on the system "foghorn2.internal",
	has examined this email to determine if it is likely to be spam.
	The original message has been attached to this so you can view it
	(if it isn't spam) or label similar future email.
	The presence of these headers does not, by itself, indicate that this
	is spam; they are provided for your information.
	The actual score awarded to this email appears in the 'X-Spam-Score'
	header; if the score is high enough that this is likely to be spam,
	then the subject line will have been modified or the message rejected,
	depending on how highly it scored.
	A summary of the scores awarded by individual tests appears below.
	If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, Mar 29, 2005 at 07:15:01AM -0500, linux-os
	wrote [snip] > > In the United States there is something called
	"restraint of trade". > Suppose there was a long-time facility or API
	that got replaced > with one that was highly restrictive. To use the
	new facility, one > would have to buy a license or kiss somebody or
	something that > was not previously required. If an action was brought
	against the > person(s) who replaced the old facility with the new one,
	it > is likely that the plaintiff would prevail. > [snip] [...] 
	Content analysis details:   (-105.8 points, 4.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-100 USER_IN_WHITELIST      From: address is in the user's white-list
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 PLING_PLING            Subject has lots of exclamation marks
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 07:15:01AM -0500, linux-os wrote
[snip]
> 
> In the United States there is something called "restraint of trade".
> Suppose there was a long-time facility or API that got replaced
> with one that was highly restrictive. To use the new facility, one
> would have to buy a license or kiss somebody or something that
> was not previously required. If an action was brought against the
> person(s) who replaced the old facility with the new one, it
> is likely that the plaintiff would prevail.
> 
[snip]

The key phrase here is 'restraint of /trade/'.  
Noone has been selling these drivers, and nonone's been dealing in
the right to use or write them. Without being a lawyer (US or otherwise),
I'd suggest that it's highly unlikely any such legislation would apply.

E.g.: suppose there are 2 snack bars within 100 yards of a school; one 
is out of sight, across an intersection and down a side street, and one
is clearly visible across an empty lot.  For years the lot has been
unfenced and, human nature being what it is, kids just walk across the
open lot.  The owner of the lot then decides to put up a high fence
around it with a combination lock on the gate (now he's raising chinchillas,
or peaches; he won't say) so all the kids start going to the other snackbar,
except for a few that he trusts with the combination.  It seems to me
you're suggesting that the snackbar owner who's lost out would have
an action for restraint of trade; I can't see it myself.


John.


[snip]
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> ------------------------------

-- 
Voice: +61 8 8202 9040
Email: jpearson@oasissystems.com.au

Oasis Systems Pty Ltd
288 Glen Osmond Road
Fullarton, South Australia 5063

Ph: + 61 8 82029000
Fax: +61 8 82029001

CAUTION: This email and any attachments may contain information that is
confidential and subject to copyright. If you are not the
intended recipient, you must not read, use, disseminate, distribute or
copy this email or any attachments. If you have received this
email in error, please notify the sender immediately by reply email and
erase this email and any attachments.

DISCLAIMER: OASIS Systems uses virus-scanning technology but accepts
no responsibility for loss or damage arising from the use of the
information transmitted by this email including damage from virus.

