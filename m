Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVARBJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVARBJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVARBJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:09:28 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:18311 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261497AbVARBHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:07:35 -0500
Message-ID: <41EC614F.9070205@cyberone.com.au>
Date: Tue, 18 Jan 2005 12:07:27 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mauricio Lin <mauricio.lin@indt.org.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A new entry for /proc
References: <3f250c7105010613115554b9d9@mail.gmail.com> <20050106202339.4f9ba479.akpm@osdl.org> <3f250c7105011414466f22fc37@mail.gmail.com> <20050114154209.6b712e55.akpm@osdl.org> <3f250c71050117100332774211@mail.gmail.com> <3f250c71050117110241dfc46c@mail.gmail.com> <20050117173023.GA22202@logos.cnet> <20050117213544.GA8896@holomorphy.com>
In-Reply-To: <20050117213544.GA8896@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Mon, Jan 17, 2005 at 03:30:23PM -0200, Marcelo Tosatti wrote:
>
>>You want to update your patch to handle the new 4level pagetables
>>which introduces a new indirection table: the PUD. 
>>Check 2.6.11-rc1 - mm/rmap.c.
>>BTW: What does PUD stand for?
>>
>
>Page Upper Directory.
>

That's right.

> It also is used in a particular euphemism that made
>it seem odd to me. I suspect it wasn't thought of when it was chosen.
>
>

No. What's the euphemism?

