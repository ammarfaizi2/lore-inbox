Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTFIVlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTFIVlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:41:06 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:44932 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262151AbTFIVlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:41:00 -0400
Date: Mon, 9 Jun 2003 23:54:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Timothy Miller <miller@techsource.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write can block)
Message-ID: <20030609215439.GA17033@wohnheim.fh-wedel.de>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com> <20030607001202.GB14475@kroah.com> <3EE4B4C3.80902@techsource.com> <20030609163959.GA13811@wohnheim.fh-wedel.de> <Pine.LNX.4.55.0306091001270.3614@bigblue.dev.mcafeelabs.com> <3EE4D80A.2050402@techsource.com> <Pine.LNX.4.55.0306091142420.3614@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.55.0306091142420.3614@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 June 2003 11:58:43 -0700, Davide Libenzi wrote:
> 
> If you try to define a bad/horrible "whatever" in an *absolute* way you
> need either the *absolutely* unanimous consent or you need to prove it
> using a logical combination of already proven absolute concepts. Since you
> missing both of these requirements you cannot say that something is
> bad/wrong in an absolute way. You can say though that something is
> wrong/bad when dropped inside a given context, and a coding standard might
> work as an example. If you try to approach a developer by saying that he
> has to use ABC coding standard because it is better that his XYZ coding
> standard you're just wrong and you'll have hard time to have him to
> understand why he has to use the suggested standard when coding inside the
> project JKL. The coding standard gives you the *rule* to define something
> wrong when seen inside a given context, since your personal judgement does
> not really matter here.

The definition in an absolute way is not the real problem.  The real
problem is that good/bad coding style has more than just one
dimension.  Trying to rate it in just one dimension will almost always
fail.

That said, this discussion appears to have zero impact on the kernel
itself, so it might be time to fade it out.

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
