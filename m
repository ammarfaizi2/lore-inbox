Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289208AbSAGNkY>; Mon, 7 Jan 2002 08:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289213AbSAGNjd>; Mon, 7 Jan 2002 08:39:33 -0500
Received: from weta.f00f.org ([203.167.249.89]:52165 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S289208AbSAGNjW>;
	Mon, 7 Jan 2002 08:39:22 -0500
Date: Tue, 8 Jan 2002 02:42:24 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@lxorguk.ukuu.org.uk
Subject: Re: "APIC error on CPUx" - what does this mean?
Message-ID: <20020107134224.GA27675@weta.f00f.org>
In-Reply-To: <E37DB7922B4@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E37DB7922B4@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.25i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 02:16:28PM +0100, Petr Vandrovec wrote:

    AFAIK it happens only on VIA based boards, and only if (AMD) CPU is using 
    APIC.

I have a dual P3 (VIA based) that does emits the Spurious Int7 message
shortly after boot (I've never checked /proc/interrupts though)
whereas my ServerWorks chipset never does this.


  --cw
