Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVDEHvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVDEHvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVDEHpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:45:51 -0400
Received: from host201.dif.dk ([193.138.115.201]:25866 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261611AbVDEHjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:39:21 -0400
Date: Tue, 5 Apr 2005 09:37:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Christoph Hellwig <hch@infradead.org>
cc: Jesper Juhl <juhl-lkml@dif.dk>, Steve French <smfrench@austin.rr.com>,
       Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] cifs: cleanup asn1.c
In-Reply-To: <20050405073559.GC26208@infradead.org>
Message-ID: <Pine.LNX.4.62.0504050936450.15967@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.62.0504042254540.2496@dragon.hyggekrogen.localhost>
 <20050405073559.GC26208@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, Christoph Hellwig wrote:

> Date: Tue, 5 Apr 2005 08:35:59 +0100
> From: Christoph Hellwig <hch@infradead.org>
> To: Jesper Juhl <juhl-lkml@dif.dk>
> Cc: Steve French <smfrench@austin.rr.com>, Steven French <sfrench@us.ibm.com>,
>     linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/4] cifs: cleanup asn1.c
> 
> On Mon, Apr 04, 2005 at 10:59:32PM +0200, Jesper Juhl wrote:
> > 
> > Hi Steve,
> > 
> > More fs/cifs/ cleanups for you. This time for asn1.c
> 
> Btw, shouldn't asn1.c move to lib/?
> 
Perhaps, I don't know, not my call. Steve will have to be the judge of 
that, I'm merely cleaning up the files found in fs/cifs/ atm.

-- 
Jesper


