Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbTLHQVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265451AbTLHQVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:21:20 -0500
Received: from intra.cyclades.com ([64.186.161.6]:13001 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265452AbTLHQVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:21:19 -0500
Date: Mon, 8 Dec 2003 14:15:27 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, <mark@symonds.net>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
In-Reply-To: <20031208165423.555c5783.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0312081414150.1289-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, Stephan von Krawczynski wrote:

> On Mon, 8 Dec 2003 08:17:30 -0200 (BRST)
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> 
> > Mark,
> > 
> > Please try the latest BK tree. There was a known bug in the netfilter code 
> > which could cause the lockups. 
> 
> ...which leads me to the most-simple question: where can I find a changelog for
> 2.4.23-bkX from www.kernel.org ? Inside ?

I believe there is nothing which generates 2.4.2x-bk changelogs right now.

It can be easily done.


