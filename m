Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTJPKuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbTJPKuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:50:19 -0400
Received: from a205017.upc-a.chello.nl ([62.163.205.17]:8832 "EHLO
	mail.fluido.as") by vger.kernel.org with ESMTP id S262839AbTJPKsf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:48:35 -0400
Date: Thu, 16 Oct 2003 12:48:36 +0200
From: "Carlo E. Prelz" <fluido@fluido.as>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031016104836.GB7454@casa.fluido.as>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston> <20031016101905.GA7454@casa.fluido.as> <1066300892.646.134.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066300892.646.134.camel@gaston>
X-operating-system: Linux casa 2.6.0-test7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
	Date: gio, ott 16, 2003 at 12:41:32 +0200

Quoting Benjamin Herrenschmidt (benh@kernel.crashing.org):

> I think it's an older version that James included as the current one
> has support for the 9200. I'm still updating it very regulary as it's
> not considered as "finished" work yet :) Though testing is welcome,
> I try to keep it working at any stage.

The version I am using *has* support for the 9200, but only recognizes
a PCI id of 5960, and my card has 5964. Thus I added the PCI id and
the card is eventually recognized as a 9200. Details are in the first
message I sent to the list.

Anyway, I now have to leave. I will try to dedicate some time to this
again tomorrow morning. I will try the rsync access.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
