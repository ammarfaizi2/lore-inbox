Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSHKS4b>; Sun, 11 Aug 2002 14:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318199AbSHKS4b>; Sun, 11 Aug 2002 14:56:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23028 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318184AbSHKS4a>; Sun, 11 Aug 2002 14:56:30 -0400
Subject: Re: [BK] [PATCH] reiserfs changeset 7 of 7 to include into 2.4 tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Hans Reiser <reiser@bitshadow.namesys.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020809183850.A17407@infradead.org>
References: <200208091636.g79GadA9007889@bitshadow.namesys.com> 
	<20020809183850.A17407@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Aug 2002 21:21:01 +0100
Message-Id: <1029097261.16421.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 18:38, Christoph Hellwig wrote:
> Are you sure you want to have a new block allocator in the stable series
> before it has been added to 2.5?

Thats what I was also wondering. It seems like its an experimental
update rather than a bug fix so ought to be 2.5 stuff

