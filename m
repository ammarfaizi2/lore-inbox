Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271746AbTGXWGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 18:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271747AbTGXWGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 18:06:01 -0400
Received: from u195-95-85-177.dialup.planetinternet.be ([195.95.85.177]:2820
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP id S271746AbTGXWGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 18:06:00 -0400
Message-Id: <200307242217.h6OMHPFk002164@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
cc: nick black <dank@suburbanjihad.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC 
In-Reply-To: Your message of "Thu, 24 Jul 2003 01:50:00 +0200."
             <816FF467B0D@vcnet.vc.cvut.cz> 
Date: Fri, 25 Jul 2003 00:17:25 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are you sure it was matroxfb and not DRI what changed?

Actually, no. I've been stuck at 2.5.46 for *ages* due to a never ending 
succession of driver issues (still not all solved by the way). 2.5.72 was 
the next kernel I could actually try to use. A lot of change takes place
over that many kernel revisions.

But "never mind" (although... :-), because...

>  Anyway, can you try applying matroxfb-2.5.72.gz from 
> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest to your tree (you can
> enable only matroxfb after patching, no other fbdev will work) and retry
> tests?

YES! No more ghost X image, no more white rectangles, no more sudden 
jump scrolling, and a backspace key that actually works again. Please 
do consider pushing (some of) this to Linus for inclusion into the 
2.6.0.test series!

Thanks,

 MCE
