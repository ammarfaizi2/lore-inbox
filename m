Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289183AbSAGNFk>; Mon, 7 Jan 2002 08:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289181AbSAGNFa>; Mon, 7 Jan 2002 08:05:30 -0500
Received: from weta.f00f.org ([203.167.249.89]:50885 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S289183AbSAGNFK>;
	Mon, 7 Jan 2002 08:05:10 -0500
Date: Tue, 8 Jan 2002 02:08:11 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@lxorguk.ukuu.org.uk
Subject: Re: "APIC error on CPUx" - what does this mean?
Message-ID: <20020107130811.GA27604@weta.f00f.org>
In-Reply-To: <E3713B21FAB@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E3713B21FAB@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.25i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 01:29:42PM +0100, Petr Vandrovec wrote:

    They are spurious IRQ 7, just message is printed only once during
    kernel lifetime... I have about three spurious IRQ 7 per each 1000
    interrupts delivered to CPU. It is on A7V (Via KT133).

Any idea _why_ these occur though?  It seems some mainboards produce a
plethora of these whilst others never produce these...




   --cw
