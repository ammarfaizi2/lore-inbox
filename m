Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbTEEICV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbTEEICU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:02:20 -0400
Received: from AMarseille-201-1-6-95.abo.wanadoo.fr ([80.11.137.95]:57383 "EHLO
	gaston") by vger.kernel.org with ESMTP id S262036AbTEEICS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:02:18 -0400
Subject: Re: Linux 2.5.69
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052122444.12384.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 May 2003 10:14:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 02:48, Linus Torvalds wrote:

> Anyway, that's fixed here, along with a lot of other updates. Much of 
> 2.5.69 is small one-liners to drivers to handle the new IRQ semantics, but 
> there's a lot of other cleanups in there too (Christoph Hellwig continued 
> on his devfs rampage, for example).
> 
> NOTE! As of this release I think I'll want to have patches either be 
> _really_ obvious, or they should go through one of more people for 
> approval. In particular, I'm hoping that the paperwork stuff with Andrew 
> should be getting closer to finalized, and that we could start moving over 
> towards a 2.6.x release schedule.. 

You still plan to get Patrick's Power Management updates in there ?

Ben.

