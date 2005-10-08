Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVJHW7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVJHW7D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 18:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVJHW7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 18:59:03 -0400
Received: from mailfe10.tele2.fr ([212.247.155.44]:43183 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751165AbVJHW7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 18:59:01 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sun, 9 Oct 2005 00:58:52 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Russell King <rmk@arm.linux.org.uk>, akpm@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] new serial flow control
Message-ID: <20051008225852.GB5150@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Russell King <rmk@arm.linux.org.uk>, akpm@osdl.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051008222711.GA5150@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault, le Sun 09 Oct 2005 00:27:11 +0200, a écrit :
> > So, we now seem to have:
> > 
> > 	Standard flow control
> > 	CTVB flow control
> > 	RS485 RTS flow control
> 
> Let's add a new one: Inka braille devices, which uses RTS/CTS as
> acknowledge strobes for each character.

Hmm: and there is DTR/DSR flow control too.

Regards,
Samuel
