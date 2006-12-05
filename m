Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968209AbWLENuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968209AbWLENuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 08:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968210AbWLENuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 08:50:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:61970 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968209AbWLENuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 08:50:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=j7aEtlQGMzXYQjYkw/NLmuXodq+lWxi2GchVQNFFDdF38Rr3lXmmrykS4goZxFNGz515JYzAv35lfVaBMKWPpowu9Yeq0JOTQau1qDEoDwItzFOJzSWIccADPCFBzJhIjBvOTrqAFn2Hbzli4nYpgzTVnYWPKGHZH88LInlDnz8=
Message-ID: <457578E2.6040108@gmail.com>
Date: Tue, 05 Dec 2006 14:49:22 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Aucoin@Houston.RR.com
CC: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: la la la la ... swappiness
References: <200612051327.kB5DRDwr011027@ms-smtp-01.texas.rr.com>
In-Reply-To: <200612051327.kB5DRDwr011027@ms-smtp-01.texas.rr.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aucoin wrote:

>> From: Rene Herman [mailto:rene.herman@gmail.com] ftruncate there
>> and some similarity to a problem I once experienced
> 
> I can't honestly say I completely grasp the fundamentals of the issue
> you experienced but we are using ext3 with data=journal

Rereading I see ext3 isn't involved at all but perhaps the ftruncate 
does something similar here as it did on ext3? Andrew? It's probably 
best to igniore me, I also never quite understood what the problem on 
ext3 was. Just thought I'd share the hunch anyway...

Rene.

