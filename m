Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVCCDTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVCCDTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVCCCRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:17:45 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:6102 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261400AbVCCCOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:14:33 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Date: Thu, 3 Mar 2005 13:14:04 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16934.29420.360075.952688@cse.unsw.edu.au>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: message from Zwane Mwaikambo on Wednesday March 2
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<20050302225846.GK17584@marowsky-bree.de>
	<Pine.LNX.4.61.0503021642120.25831@montezuma.fsmlabs.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 2, zwane@arm.linux.org.uk wrote:
>                                                   A Linus based odd number 
> might be closer to that if we hope on people unwittingly running them.
                                               ^^^^^^^^^^^

I think this is a very unhelpful attitude.  Don't expect people to do
things unwittingly.  It won't work.

You should expect people to be more intelligent and more confused than
you expect (yes, I know that is recursive).

Being more intelligent means you won't be able to trick them.
Being more confused means they will try out less things.

Constantly changing the naming will confuse people, and they will
experiment less.
Having some clear and often-stated gaols for different releases -
which are adhered to - will make people feel less confused and so more
willing to experiment.  Asking nicely probably helps too.

--e.g.--
The latest 2.6.X is stable. Feel free to use it for any system.
The latest 2.6.X-pre is fairly stable.  Please consider using it on
     non-"mission critical" system.
The latest 2.6.X-mmY is under development. Please test it if you have
     the opportunity.


Agree on that.  Stick to it.  Get everyone to plaster it on their
websites.  Stick it at the bottom of all @vger.kernel.org mailing
lists. See what happens.

NeilBrown
