Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSHIRfH>; Fri, 9 Aug 2002 13:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSHIRfH>; Fri, 9 Aug 2002 13:35:07 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:22539 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315198AbSHIRfH>; Fri, 9 Aug 2002 13:35:07 -0400
Date: Fri, 9 Aug 2002 18:38:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@bitshadow.namesys.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [BK] [PATCH] reiserfs changeset 7 of 7 to include into 2.4 tree
Message-ID: <20020809183850.A17407@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@bitshadow.namesys.com>,
	marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <200208091636.g79GadA9007889@bitshadow.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208091636.g79GadA9007889@bitshadow.namesys.com>; from reiser@bitshadow.namesys.com on Fri, Aug 09, 2002 at 08:36:39PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 08:36:39PM +0400, Hans Reiser wrote:
> Hello!
> 
>    This changeset implements new block allocator for reiserfs and adds one
>    more tail policy. This is a product of continuous NAMESYS research in this
>    area. This piece of code incorporates work by Alexander Zarochencev, 
>    Jeff Mahoney and Oleg Drokin.

Are you sure you want to have a new block allocator in the stable series
before it has been added to 2.5?

