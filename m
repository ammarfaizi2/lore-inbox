Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTAaPlQ>; Fri, 31 Jan 2003 10:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTAaPlQ>; Fri, 31 Jan 2003 10:41:16 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:475 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261427AbTAaPlP>;
	Fri, 31 Jan 2003 10:41:15 -0500
Date: Fri, 31 Jan 2003 15:46:49 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030131154649.GA16627@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <20030131104326.GF12286@louise.pinerecords.com.suse.lists.linux.kernel> <200301311112.h0VBCv00000575@darkstar.example.net.suse.lists.linux.kernel> <20030131132221.GA12834@codemonkey.org.uk.suse.lists.linux.kernel> <1044025785.1654.13.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <p73hebpqqn4.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73hebpqqn4.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 04:34:55PM +0100, Andi Kleen wrote:

 > If you want to make debugging easy for laptops write a USB or firewire
 > console.

irda too maybe ?
 
 > Firewire is actually quite interesting because it can even
 > do DMA, so you could peek into the memory.

kgdb-over-firewire ? 8-)

 > Morse is not helpful.
 > 
 > I admit I was the on who got this ball running by suggesting it "as an 
 > exercise for the reader" in the original panic blink code, but
 > guys this was intended as a JOKE, not serious. Please get over it
 > and don't merge that silly code.
 
A voice of sanity.. I think you made a monster with that comment 8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
