Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264876AbTF0V7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 17:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbTF0V7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 17:59:15 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:24491 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264870AbTF0V7K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 17:59:10 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 27 Jun 2003 15:11:53 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "David S. Miller" <davem@redhat.com>
cc: mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
In-Reply-To: <20030627.150248.08328103.davem@redhat.com>
Message-ID: <Pine.LNX.4.55.0306271509540.4457@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com>
 <20030627.143738.41641928.davem@redhat.com>
 <Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com>
 <20030627.150248.08328103.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jun 2003, David S. Miller wrote:

>    From: Davide Libenzi <davidel@xmailserver.org>
>    Date: Fri, 27 Jun 2003 15:02:00 -0700 (PDT)
>
>    David, your method is the dream of every software developer.
>
> It is not a dream, it works perfectly fine and has done so
> for 5+ years of Linux maintainence.
>
> To make these things scale you MUST push the work out to other people,
> you absolutely cannot centralize.  And here we're pushing it out to
> the bug reporters, just like we push the work of patch maintainence to
> the patch submitters.
>
> If they don't care about the bug and won't retransmit when their
> stuff isn't being looked at, their bug isn't worth being looked
> at.

David, I'm not willing to waste both precious time arguing on this but I
will leave you question to think about. Is a bug report more useful for
the user of a "system" or for the "system" itself ?



- Davide

