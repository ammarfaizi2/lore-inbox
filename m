Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267589AbUH0TiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267589AbUH0TiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267596AbUH0Thg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:37:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39306 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267589AbUH0Ted
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:34:33 -0400
Message-ID: <412F8CBC.4040003@pobox.com>
Date: Fri, 27 Aug 2004 15:34:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Craig Milo Rogers <rogers@isi.edu>, Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webcam@smcc.demon.nl
Subject: Re: Termination of the Philips Webcam Driver (pwc)
References: <20040826233244.GA1284@isi.edu> <20040827004757.A26095@infradead.org> <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org> <20040827094346.B29407@infradead.org> <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales> <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org> <20040827185541.GC24018@isi.edu> <Pine.LNX.4.58.0408271157540.14196@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408271157540.14196@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Whenever somebody says "accept the driver to help users", they are missing
> the big picture. A binary driver SCREWS OVER users on other architectures.  
> It pretty much guarantees that those other architectures will never be
> supported. (And that's totally ignoring the maintenance issues even on
> regular x86).

Amen.

This has been a big problem in wireless area, where vendors love to 
provide BLOBs of code which inevitably work only on 32-bit x86.

	Jeff


