Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVBJFr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVBJFr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 00:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVBJFr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 00:47:28 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:27777 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S262024AbVBJFrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 00:47:24 -0500
Message-ID: <420AF563.1030309@andrew.cmu.edu>
Date: Thu, 10 Feb 2005 00:47:15 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Stelian Pop <stelian@popies.net>, Francois Romieu <romieu@fr.zoreil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
References: <20050204160631.GB26748@bitmover.com> <20050204170306.GB3467@crusoe.alcove-fr> <20050204183922.GC27707@bitmover.com> <20050204200507.GE5028@deep-space-9.dsnet> <20050204201157.GN27707@bitmover.com> <20050204214015.GF5028@deep-space-9.dsnet> <20050204233153.GA28731@electric-eye.fr.zoreil.com> <20050205193848.GH5028@deep-space-9.dsnet> <20050205233841.GA20875@bitmover.com> <20050208154343.GH3537@crusoe.alcove-fr> <20050208155845.GB14505@bitmover.com>
In-Reply-To: <20050208155845.GB14505@bitmover.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I agree with your overall sentiment, please compare apples to 
apples regarding the license.  You said:

Larry McVoy wrote:
> I don't come here every month and ask for
> the GPL to be removed from some driver, that's essentially what you are
> doing and I think pretty much everyone is sick of it.

The GPL doesn't state that "You and anyone at your company are not 
allowed to work on any operating system software under any non-GPL 
license."  While that would be a perfectly valid license (just like the 
BK one), obviously it would generate a fairly steady stream of 
complaints.  It's not like people have stopped complaining about how the 
GPL forces them to release any code they link with it.  The boundary of 
a license will always create friction.  This will be especially true as 
in the BK license, which was expressly designed to be irritating to a 
certain class of people (who now whine about it).

A more directly relevant example would be the following: What if a new 
version of CVS had a license with a clause stating the following: "Any 
repository touched by CVS 1.2 may not be imported into into BK, unless 
you first remove all checkin comments.  This is because we don't help 
people who are competing with us."  Sure, that's a 100% legitimate 
license, and binding due to standard copyright goodness, yet I would 
expect BitMover people to complain about it.  What we have now is 
exactly the same thing in reverse.  Get used to the complaints because 
your license is achieving exactly what you meant it to do.

  - Jim
