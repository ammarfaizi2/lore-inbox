Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266326AbUBLKfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 05:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUBLKfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 05:35:09 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:62692 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266326AbUBLKfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 05:35:06 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: dmapool (was: Re: Linux 2.6.3-rc2)
Date: 12 Feb 2004 11:25:09 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87smhglhmi.fsf@bytesex.org>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org> <Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be> <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be> <20040210145558.A4684@infradead.org> <20040210162259.GA26620@kroah.com> <Pine.GSO.4.58.0402101727130.2261@waterleaf.sonytel.be> <20040210101437.1507af3b.davem@redhat.com> <Pine.GSO.4.58.0402121048550.7297@waterleaf.sonytel.be>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1076581509 5955 127.0.0.1 (12 Feb 2004 10:25:09 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Feel free to move the stubs to asm-generic/no-dma-mapping.h, if there are
> enough users to warrant that.

Yes, please.  user-mode-linux needs this too.

  Gerd

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins
