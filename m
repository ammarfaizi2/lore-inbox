Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSCJRvX>; Sun, 10 Mar 2002 12:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293133AbSCJRvN>; Sun, 10 Mar 2002 12:51:13 -0500
Received: from ns.ithnet.com ([217.64.64.10]:23815 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S293135AbSCJRu4>;
	Sun, 10 Mar 2002 12:50:56 -0500
Date: Sun, 10 Mar 2002 18:50:37 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020310185037.2af0488d.skraw@ithnet.com>
In-Reply-To: <E16jmF2-0002GF-00@the-village.bc.nu>
In-Reply-To: <20020309131956.77ebf679.skraw@ithnet.com>
	<E16jmF2-0002GF-00@the-village.bc.nu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Mar 2002 19:10:52 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > I just upgraded a host from 2.2.19 to 2.2.21-pre3 and discovered a problem with kernel nfs. Setup is this:
> > 
> > knfs-server is 2.4.19-pre2
> > knfs-client is 2.2.21-pre3
> 
> Do you see this with 2.2.20 (2.2.20 has NFS changes in the client, 2.2.21pre
> does not) ?

Hello Alan,

sorry for delayed answer. The machine in question is in production, and I had to find some other test candidate first. So here we go:

1) The problem is reproducable on another hardware with 2.2.21-pre3 client.
2) The problem is reproducable with 2.2.20 either.

What to test next?

Regards,
Stephan
 
