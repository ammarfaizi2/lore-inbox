Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbVAQVg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVAQVg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVAQVg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:36:27 -0500
Received: from holomorphy.com ([66.93.40.71]:21165 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262895AbVAQVgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:36:22 -0500
Date: Mon, 17 Jan 2005 13:35:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Mauricio Lin <mauriciolin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mauricio Lin <mauricio.lin@indt.org.br>, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] A new entry for /proc
Message-ID: <20050117213544.GA8896@holomorphy.com>
References: <3f250c7105010613115554b9d9@mail.gmail.com> <20050106202339.4f9ba479.akpm@osdl.org> <3f250c7105011414466f22fc37@mail.gmail.com> <20050114154209.6b712e55.akpm@osdl.org> <3f250c71050117100332774211@mail.gmail.com> <3f250c71050117110241dfc46c@mail.gmail.com> <20050117173023.GA22202@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117173023.GA22202@logos.cnet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 03:30:23PM -0200, Marcelo Tosatti wrote:
> You want to update your patch to handle the new 4level pagetables
> which introduces a new indirection table: the PUD. 
> Check 2.6.11-rc1 - mm/rmap.c.
> BTW: What does PUD stand for?

Page Upper Directory. It also is used in a particular euphemism that made
it seem odd to me. I suspect it wasn't thought of when it was chosen.


-- wli
