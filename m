Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSHIUvD>; Fri, 9 Aug 2002 16:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHIUvD>; Fri, 9 Aug 2002 16:51:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59656 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316135AbSHIUvC>;
	Fri, 9 Aug 2002 16:51:02 -0400
Message-ID: <3D542B88.6F7007E4@zip.com.au>
Date: Fri, 09 Aug 2002 13:52:24 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@bitshadow.namesys.com>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [BK] [PATCH] reiserfs changeset 7 of 7 to include into 2.4 tree
References: <200208091636.g79GadA9007889@bitshadow.namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> 
> Hello!
> 
>    This changeset implements new block allocator for reiserfs and adds one
>    more tail policy. This is a product of continuous NAMESYS research in this
>    area. This piece of code incorporates work by Alexander Zarochencev,
>    Jeff Mahoney and Oleg Drokin.

What Christoph said ;)

Block allocation algorithms are really, really important.  I'd be very interested
in a description of what this change does, what problems it is solving, how it
solves them, observed results, testing methodology, etc.   Is such a thing
available?

Thanks.
