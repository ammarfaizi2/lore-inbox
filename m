Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbUJ1XrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbUJ1XrB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbUJ1Xps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:45:48 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:32191 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263092AbUJ1Xog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:44:36 -0400
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 7/7] uml: resolve symbols in back-traces
Date: Fri, 29 Oct 2004 01:44:11 +0200
User-Agent: KMail/1.7.1
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Dike <jdike@addtoit.com>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>
References: <200410272223.i9RMNj921852@mail.osdl.org> <200410282132.i9SLWhA3004709@ccure.user-mode-linux.org> <20041028205136.GA1888@taniwha.stupidest.org>
In-Reply-To: <20041028205136.GA1888@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410290144.11700.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 22:51, Chris Wedgwood wrote:
> On Thu, Oct 28, 2004 at 05:32:43PM -0400, Jeff Dike wrote:
> > They're not completely pointless, they just cater to an individual's
> > development environment, and that sort of stuff should be in the
> > environment, and not the code.
>
> unnecessary in the code then, the exception to this perhaps being the
> compile-command stuff that was (still is?) in some of the network
> drivers as that really is per-file state
??? I don't understand you well. If there are compile-commands for emacs, 
they're broken too - using make namefile.o ARCH=um is the kernel universal 
solution.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
