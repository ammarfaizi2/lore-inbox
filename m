Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271210AbTGWTEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271226AbTGWTDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:03:53 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:59154
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S271210AbTGWTC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:02:28 -0400
Date: Wed, 23 Jul 2003 12:08:45 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Diehl <lists@mdiehl.de>, Adrian Bunk <bunk@fs.tum.de>,
       "Adam J. Richter" <adam@yggdrasil.com>, andersen@codepoet.org,
       jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
In-Reply-To: <1058965063.5516.41.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10307231202520.13376-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

The simple flaw is present and pointed out in my inital statement.

GPL provides no means to enable the author/copyright holder to defend and
recover legal fees occurred during discovery and litigation.

What I find odd in you politics which stinks, is you and redhat are
pumping OSL into new features which are not generally submitted to the
standard base.  I do not care, but it does look funny.

Interesting points how the issues of holding the kernel to GPLv2 may
actually be a restriction to invalidate the actually license.  This tends
to make it possible for more arguements against the author when pursuing
violations.

Just a nickel to stir the pot.

Andre Hedrick
LAD Storage Consulting Group

On 23 Jul 2003, Alan Cox wrote:

> On Mer, 2003-07-23 at 13:32, Martin Diehl wrote:
> > If the copyright holder puts a note on his code saying it is released 
> > under version 2 of the GPL then clearly neither the "or any later" nor the 
> > "not specified" cases apply. And I really fail to see how one could 
> > argue this were an additional restriction compared to GPL v2 literally!
> 
> If the copyright holder is not permitted to make such a restriction and
> use the existing code then yes.
> 
> > Btw, you aren't saying linux-kernel would *not* come with a valid GPL, 
> > according to linux/COPYING, are you?
> 
> The kernel is under GPL. I'm not sure what Linus scribblings make change
> if anything. I understand why Linus did it "I dont want the FSF doing 
> something silly" and also why the FSF did it "so we can fix the license".
> 
> Ultimately it makes little difference, Linus is perfectly entitled to
> refuse to add anything that doesn't allow GPLv2 use to his kernel tree.
> 
> GPLv2 only effectively means your code becomes non-free if a flaw is
> found in that GPL revision, and nobody can fix it for 70 years so its
> an awkward trade off
> 
> I suspect this is getting offtopic 8)
> 

