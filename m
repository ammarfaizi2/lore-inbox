Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbTF0W5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTF0W5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:57:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24457
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264900AbTF0W5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:57:50 -0400
Subject: Re: networking bugs and bugme.osdl.org
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: greearb@candelatech.com, davidel@xmailserver.org, mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20030627.151906.102571486.davem@redhat.com>
References: <3EFCBD12.3070101@candelatech.com>
	 <20030627.145456.115915594.davem@redhat.com>
	 <3EFCC1EB.2070904@candelatech.com>
	 <20030627.151906.102571486.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056755336.5459.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 00:08:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-27 at 23:19, David S. Miller wrote:
>    Forcing people to continue to retransmit the same report just pisses
>    people off, and in the end will get you less useful reports than if
>    you had flagged the report as 'please-gimme-more-info'.
> 
> And this is different from patch submission in what way?

Tried doing an SQL query or text analysis for similarities on random
messages lurking in private mailboxes or mixed up in list archives.
Its really hard.

Now try doing that with bugzilla and its really easy. Nobody is saying
"Dave shall use bugzilla", maybe you can find an underling to care,
maybe the only time you want to use it is to say "thats really freaky,
who else is seeing it and what hardware"

>From Red Hat bugzilla I've done statistical analysis of IDE failure
patterns, I've also  dug up year old mislaid patches that would have
been lost forever otherwise because the one person who fixed it was
missed in the noise, even though lots of the noise was people hitting
that same bug

