Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTEWLZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 07:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbTEWLZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 07:25:55 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:49170 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264027AbTEWLZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 07:25:55 -0400
Date: Fri, 23 May 2003 10:37:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, marcelo@conectiva.com.br
Cc: Arnd Bergmann <arnd@arndb.de>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Patch to add SysRq handling to 3270 console
Message-ID: <20030523103740.A15552@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	marcelo@conectiva.com.br, Arnd Bergmann <arnd@arndb.de>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
References: <OF52A877A4.CB4F43A8-ONC1256D2F.00336EBB@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF52A877A4.CB4F43A8-ONC1256D2F.00336EBB@de.ibm.com>; from schwidefsky@de.ibm.com on Fri, May 23, 2003 at 11:30:38AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 11:30:38AM +0200, Martin Schwidefsky wrote:
> code drop contains the changes & new features for the new machine. The
> IBM process forces us to publish the new features patches on developer
> works first before we can think about integration into the mainline.
> You may not like it but this is a restriction we as the s390 team at
> IBM have to live with.

*sigh*  what about at least posting patches vs a current kernel? :)

> > Btw, what's the state of 2.4.21-rc3 vs s390(x)?
> No too good. It basically works but there is a big bunch of patches
> missing. I sent them to Marcelo for integration a few weeks ago but
> to me Marcelo is a black hole. Never heard anything about it, not
> even a "no". I sent Alan a copy of the patches adapted to his -ac
> tree. He accepted most of it into rc2-ac2.

Marcelo, what's the state of the s390 updates?  

