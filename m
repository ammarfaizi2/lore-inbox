Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270219AbTGWMyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 08:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270244AbTGWMyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 08:54:22 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:40183 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270219AbTGWMyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 08:54:21 -0400
Subject: Re: Promise SATA driver GPL'd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Diehl <lists@mdiehl.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andre Hedrick <andre@linux-ide.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andersen@codepoet.org,
       jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307231425130.12651-100000@notebook.home.mdiehl.de>
References: <Pine.LNX.4.44.0307231425130.12651-100000@notebook.home.mdiehl.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058965063.5516.41.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 13:57:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 13:32, Martin Diehl wrote:
> If the copyright holder puts a note on his code saying it is released 
> under version 2 of the GPL then clearly neither the "or any later" nor the 
> "not specified" cases apply. And I really fail to see how one could 
> argue this were an additional restriction compared to GPL v2 literally!

If the copyright holder is not permitted to make such a restriction and
use the existing code then yes.

> Btw, you aren't saying linux-kernel would *not* come with a valid GPL, 
> according to linux/COPYING, are you?

The kernel is under GPL. I'm not sure what Linus scribblings make change
if anything. I understand why Linus did it "I dont want the FSF doing 
something silly" and also why the FSF did it "so we can fix the license".

Ultimately it makes little difference, Linus is perfectly entitled to
refuse to add anything that doesn't allow GPLv2 use to his kernel tree.

GPLv2 only effectively means your code becomes non-free if a flaw is
found in that GPL revision, and nobody can fix it for 70 years so its
an awkward trade off

I suspect this is getting offtopic 8)

