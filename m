Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262999AbVCDTsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbVCDTsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbVCDTsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:48:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:14821 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262998AbVCDTWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:22:19 -0500
Date: Fri, 4 Mar 2005 11:21:52 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       jgarzik@pobox.com, davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304192152.GB30241@kroah.com>
References: <20050303151752.00527ae7.akpm@osdl.org> <1109894511.21781.73.camel@localhost.localdomain> <20050303182820.46bd07a5.akpm@osdl.org> <1109933804.26799.11.camel@localhost.localdomain> <20050304032820.7e3cb06c.akpm@osdl.org> <1109940685.26799.18.camel@localhost.localdomain> <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org> <Pine.LNX.4.58.0503041020130.25732@ppc970.osdl.org> <20050304183804.GB29857@kroah.com> <Pine.LNX.4.58.0503041107320.11349@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503041107320.11349@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 11:12:22AM -0800, Linus Torvalds wrote:
> But automation takes time to build up and learn, and in the meantime doing 
> it by hand and learning early is definitely the right thing to do. Maybe 
> you doing it by hand just makes it clear that I was wrong about the need 
> for some strict rules that are automatically enforced in the first place.

Heh, it will have to be done by hand for a while, as I don't think any
of us want to write a kernel-patch-managemement-system in our spare
time.  Although, I do know that osdl's PLM at one time was planned to be
such a tool, I'll go kick the developers over there to see what they
say...

> > And if you disagree, what _should_ we call it?  "-sucker" isn't good, as
> > it only describes the people creating the tree, not any of the users :)
> 
> Let's try with the 2.6.x.y numbering scheme, it's simple, and maybe it 
> ends up being sufficient. I just wanted to bring up the point that I don't 
> think the sucker tree _has_ to be seen as a 2.6.x.y tree at all.

Fair enough, I'll stick with 2.6.x.y, as I think it's a good
representation of what people expect.  If people start objecting, I'm
always open for change.

thanks,

greg k-h
