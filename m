Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVAHWd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVAHWd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVAHWd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:33:27 -0500
Received: from orb.pobox.com ([207.8.226.5]:2703 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261972AbVAHWbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:31:07 -0500
Date: Sat, 8 Jan 2005 14:30:59 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
Message-ID: <20050108223059.GB4306@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <je8y73zl35.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <je8y73zl35.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 10:07:10PM +0100, Andreas Schwab wrote:
> I don't think it was ever being used for anything besides a.out so IMHO it
> should depend on BINFMT_AOUT.

FWIW (I don't know how accurate it is -- it's Slashdot after all -- but
it might be worth reading):
http://linux.slashdot.org/comments.pl?sid=135324&cid=11292046

-Barry K. Nathan <barryn@pobox.com>

