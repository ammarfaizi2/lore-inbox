Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTEMUAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTEMUAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:00:47 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:34568 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263245AbTEMT7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:59:31 -0400
Date: Tue, 13 May 2003 22:12:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513201206.GA11428@mars.ravnborg.org>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@oss.sgi.com>
References: <20030513165926.GA1170@mars.ravnborg.org> <Pine.GSO.4.21.0305132203330.13355-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0305132203330.13355-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 10:07:43PM +0200, Geert Uytterhoeven wrote:
> There's still almost daily activity in the Linux/MIPS CVS tree, but compared to
> mainline, it's a bit outdated (the main trunk is at 2.5.47, the 2.4 branch at
> 2.4.21-pre4).

It must have been before that I checked mainline then - I just remembered
it looked terribly outdated.

I will take a look soon to get Makefiles in shape.

	Sam
