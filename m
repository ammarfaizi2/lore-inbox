Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUJDNIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUJDNIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUJDNIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:08:42 -0400
Received: from colin2.muc.de ([193.149.48.15]:42246 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268132AbUJDNIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:08:40 -0400
Date: 4 Oct 2004 15:08:39 +0200
Date: Mon, 4 Oct 2004 15:08:39 +0200
From: Andi Kleen <ak@muc.de>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Florian Bohrer <Florian.Bohrer@t-online.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] AES x86-64-asm impl.
Message-ID: <20041004130839.GA9075@muc.de>
References: <2KWl4-wq-25@gated-at.bofh.it> <m3acv4zz5f.fsf@averell.firstfloor.org> <41613937.8BF0FE0D@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41613937.8BF0FE0D@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 02:51:19PM +0300, Jari Ruusu wrote:
> Andi Kleen wrote:
> > Florian.Bohrer@t-online.de (Florian Bohrer) writes:
> > > the asm-code is from Jari Ruusu (loop-aes).
> > > the org. glue-code is from Fruhwirth Clemens.
> > 
> > Thanks. I will add it to the x86-64 patchkit.
> 
> Here we go again...
> 
> Linus promised that he will not merge my code, and I am quite happy with my
> code not being anywhere near mainline linux cryptoapi.
> 
> Linus, please consider dropping this.

Ok, I will drop that version and go back to the older version based
on the i386 code.

-Andi
