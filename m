Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbTF2Aa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 20:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265497AbTF2Aa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 20:30:58 -0400
Received: from franka.aracnet.com ([216.99.193.44]:42128 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265426AbTF2Aa5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 20:30:57 -0400
Date: Sat, 28 Jun 2003 17:44:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
       greearb@candelatech.com, davidel@xmailserver.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <1340000.1056847487@[10.10.2.4]>
In-Reply-To: <1056828052.6295.31.camel@dhcp22.swansea.linux.org.uk>
References: <3EFCC1EB.2070904@candelatech.com> <20030627.151906.102571486.davem@redhat.com> <3EFCC6EE.3020106@candelatech.com> <20030627.170022.74744550.davem@redhat.com> <20030628001954.GD18676@work.bitmover.com> <34700000.1056760028@[10.10.2.4]> <1056828052.6295.31.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Saturday, June 28, 2003 20:20:53 +0100):

> On Sad, 2003-06-28 at 01:27, Martin J. Bligh wrote:
>> That's a trivial change to make if you want it. we just add a "reviewed"
>> / "certified" state between "new" and "assigned". Yes, might be a good 
>> idea.  I'm not actually that convinced that "assigned" is overly useful
>> in the context of open-source, but that's a separate discussion.
> 
> Most bugzilla's seem to use VERIFIED for this, and it means people who
> have better things to do can just pull bugs that are verified and/or
> tagged with "patch" in the attachments

Hmmm. we have VERIFIED set up to mean that the proposed fix has been
verified to work. Could reshuffle it, or we could find a different
word I guess - reusing the same one might cause confusion (on the
other hand ...using the same word for different things in different
bugzillas is confusing too ...)

M.


