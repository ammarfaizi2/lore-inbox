Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUJDMJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUJDMJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268069AbUJDMJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:09:13 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:3346 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268060AbUJDMJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:09:09 -0400
Message-ID: <4d8e3fd3041004050927c42438@mail.gmail.com>
Date: Mon, 4 Oct 2004 14:09:08 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Subject: Re: [PATCH] AES x86-64-asm impl.
Cc: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>,
       Florian Bohrer <florian.bohrer@t-online.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <41613937.8BF0FE0D@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2KWl4-wq-25@gated-at.bofh.it>
	 <m3acv4zz5f.fsf@averell.firstfloor.org>
	 <41613937.8BF0FE0D@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Oct 2004 14:51:19 +0300, Jari Ruusu
<jariruusu@users.sourceforge.net> wrote:
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

I guess Linus will do so,
but may I ask you why don't you want to see your code merged in mainline ?

Thanks.

-- 
Paolo
Personal home page: www.ciarrocchi.tk
See my photos: http://paolociarrocchi.fotopic.net/
Buy cool stuff here: http://www.cafepress.com/paoloc
