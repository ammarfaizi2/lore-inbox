Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266094AbSKTNS2>; Wed, 20 Nov 2002 08:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbSKTNS2>; Wed, 20 Nov 2002 08:18:28 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1409 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266094AbSKTNS0>; Wed, 20 Nov 2002 08:18:26 -0500
Subject: Re: [PATCH-2.5.47-ac6] Updates to BIOS IDE timings code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: alan@xorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021120104313.GA1855@tmathiasen>
References: <20021120104313.GA1855@tmathiasen>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 13:53:50 +0000
Message-Id: <1037800430.3267.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 10:43, Torben Mathiasen wrote:
> What hasn't been addresses yet, but that I'm working on is proper simplex
> detection when 'biostimings' are used. However, to me it seems like the simplex
> code is in the middle of being updated, right? On some chipsets we make just
> dma_base isn't set on both interfaces if device claims to be simplex. On others
> we force dma on both channels if simplex mode, why?

See the documentation for the chips concerned, that ought to make it
more obvious. I dont think any of the examples I have docs for are
non-NDA'd 8(


Alan

