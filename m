Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbTJINty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 09:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTJINty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 09:49:54 -0400
Received: from intra.cyclades.com ([64.186.161.6]:13187 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261963AbTJINtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 09:49:53 -0400
Date: Thu, 9 Oct 2003 10:52:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Willy TARREAU <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, <andersen@codepoet.org>,
       <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: iproute2 not compiling anymore
In-Reply-To: <20031005130044.GA8861@pcw.home.local>
Message-ID: <Pine.LNX.4.44.0310091051240.3040-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Oct 2003, Willy TARREAU wrote:

> Hi Marcelo, all,
> 
> On Sun, Oct 05, 2003 at 09:42:30AM -0300, Marcelo Tosatti wrote:
> > In previous messages you said iproute used to compile on "olders" 2.4.x 
> > kernel but doesnt compile anymore on recent 2.4. Is that information 
> > correct ? 
> > 
> > Can you tell me in more detail what is failing?
> 
> Just tested, and I confirm this too :

Willy,

David seems to have fixed it. Mind trying to again with the latest BK 
tree?

Danke

