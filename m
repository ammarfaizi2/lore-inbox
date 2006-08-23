Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWHWLLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWHWLLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWHWLLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:11:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:16017 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964858AbWHWLLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:11:21 -0400
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 23 Aug 2006 13:11:19 +0200
From: "Robert Szentmihalyi" <robert.szentmihalyi@gmx.de>
In-Reply-To: <2c0942db0608230355s74af2717g78675ea56b689fc0@mail.gmail.com>
Message-ID: <20060823111119.203710@gmx.net>
MIME-Version: 1.0
References: <20060823091652.235230@gmx.net>
 <2c0942db0608230355s74af2717g78675ea56b689fc0@mail.gmail.com>
Subject: Re: Group limit for NFS exported file systems
To: ray-gmail@madrabbit.org
X-Authenticated: #26149461
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On 8/23/06, Robert Szentmihalyi <robert.szentmihalyi@gmx.de> wrote:
> > is there a group limit for NFS exported file systems in recent kernels?
> > One if my users cannot access directories that belong to a group he
> actually _is_ a
> > member of. That, however, is true only when accessing them over NFS. On
> the local file
> > system, everything is fine. UIDs and GIDs are the same on client and
> server, so that
> > cannot be the problem. Client and server run Gentoo Linux with kernel
> 2.6.16 on the
> > server and 2.6.17 on the client.
> 
> Is he a member of more than 16 groups?

Yes. He is actually a member of 27 groups.
Is the limit of 16 groups still current? I was under the impression that it is a limitation of 2.4 kernels....
Is there any proper work-around for this?

Thanks,
 Robert
