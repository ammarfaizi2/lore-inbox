Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWHHP7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWHHP7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWHHP7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:59:51 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:61352 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1030182AbWHHP7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:59:50 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Kirill Korotaev <dev@sw.ru>
Subject: Re: [PATCH] unserialized task->files changing (v2)
Date: Tue, 8 Aug 2006 17:59:48 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xemul@sw.ru,
       hch@infradead.org
References: <44D87611.7070705@sw.ru> <200608081451.58305.dada1@cosmosbay.com> <44D8B35D.2070908@sw.ru>
In-Reply-To: <44D8B35D.2070908@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081759.48434.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 17:53, Kirill Korotaev wrote:
> Eric,
>
> > Sorry but there is something I dont understand. You ignored my point.
>
> Sorry, I missed it thinking that you are talking about another thing...
> Pavel described the race in more details and why barrier doesn't help.
> Hope, it became more clear now.

Yes it became very clear :)
Sorry for the confusion.

Thank you

Eric
