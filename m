Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbTCHWUn>; Sat, 8 Mar 2003 17:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262241AbTCHWUn>; Sat, 8 Mar 2003 17:20:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64691
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262239AbTCHWUm>; Sat, 8 Mar 2003 17:20:42 -0500
Subject: Re: [PATCH] register_blkdev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, Greg KH <greg@kroah.com>,
       Andries.Brouwer@cwi.nl, akpm@digeo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030308215239.A782@infradead.org>
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl>
	 <20030308005333.GF23071@kroah.com> <20030308073407.A24272@infradead.org>
	 <20030308192908.GB26374@kroah.com> <20030308194331.A31291@infradead.org>
	 <20030308214130.GK2835@ca-server1.us.oracle.com>
	 <20030308215239.A782@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047166634.26807.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 08 Mar 2003 23:37:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 21:52, Christoph Hellwig wrote:
> > 	Wait, so ugly hacks that steal every remaining major
> 
> What hack to steal every remaining major?  Remember that Linus already said
> that there won't be new static majors anyway.

No vendor I have spoken too intends to care what Linus thinks about it.
Linus tried this in 2.4. We all got together to create a numbering
repository instead of letting Linus do it.


