Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288960AbSAXTk6>; Thu, 24 Jan 2002 14:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288962AbSAXTkt>; Thu, 24 Jan 2002 14:40:49 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:54001 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S288960AbSAXTkk>; Thu, 24 Jan 2002 14:40:40 -0500
Message-Id: <200201241940.g0OJec915309@fubini.pci.uni-heidelberg.de>
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd.schubert@tc.pci.uni-heidelberg.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at slab.c:1200!
Date: Thu, 24 Jan 2002 20:40:35 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0201241416470.29313-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0201241416470.29313-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 January 2002 20:17, you wrote:
> > Jan 24 17:16:19 noether kernel: kernel BUG at slab.c:1200!
>
> so the slab is corrupted.  you need to decode the oops,
> so the backtrace can be seen.  this is described in the faq.

O.k. I'll try to do it tomorrow, but I think its a RAM problem, memtest86 just found several errors and it hasn't finished yet.

Bernd
