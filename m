Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUHCSeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUHCSeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266806AbUHCSeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:34:14 -0400
Received: from the-village.bc.nu ([81.2.110.252]:24252 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266796AbUHCSeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:34:09 -0400
Subject: Re: dma problems with Serverworks CSB5 chipset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Richard Wohlstadter <rwohlsta@watson.wustl.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20040803180821.GB6265@logos.cnet>
References: <4107E4B3.6070904@watson.wustl.edu>
	 <20040803180821.GB6265@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091554289.3898.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 18:31:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-03 at 19:08, Marcelo Tosatti wrote:
> ServerWorks OSB4/5 chipsets are known to not work reliably with the Linux
> IDE code. AFAIK its a hardware problem which we dont correctly work around.
> 
> Have you tried disabling DMA?
> 
> Bart and Alan are IDE experts, they can probably give you more useful
> information.

CSB5 is reliable, rock solidly so in my experience. OSB4 was the older
interface with problems. Are these systems SMP, what disks are you using
and in what IDE mode ?

