Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbTF1TL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbTF1TK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:10:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45706
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265366AbTF1TJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:09:45 -0400
Subject: Re: networking bugs and bugme.osdl.org
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
       greearb@candelatech.com, davidel@xmailserver.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <34700000.1056760028@[10.10.2.4]>
References: <3EFCC1EB.2070904@candelatech.com>
	 <20030627.151906.102571486.davem@redhat.com>
	 <3EFCC6EE.3020106@candelatech.com>
	 <20030627.170022.74744550.davem@redhat.com>
	 <20030628001954.GD18676@work.bitmover.com>
	 <34700000.1056760028@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056828052.6295.31.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 20:20:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-28 at 01:27, Martin J. Bligh wrote:
> That's a trivial change to make if you want it. we just add a "reviewed"
> / "certified" state between "new" and "assigned". Yes, might be a good 
> idea.  I'm not actually that convinced that "assigned" is overly useful
> in the context of open-source, but that's a separate discussion.

Most bugzilla's seem to use VERIFIED for this, and it means people who
have better things to do can just pull bugs that are verified and/or
tagged with "patch" in the attachments

