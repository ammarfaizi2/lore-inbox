Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVAQWaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVAQWaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVAQWYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:24:51 -0500
Received: from colin2.muc.de ([193.149.48.15]:19208 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261500AbVAQWJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:09:02 -0500
Date: 17 Jan 2005 23:08:56 +0100
Date: Mon, 17 Jan 2005 23:08:56 +0100
From: Andi Kleen <ak@muc.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jan Hubicka <jh@suse.cz>,
       Jack F Vogel <jfv@bluesong.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
Message-ID: <20050117220856.GA167@muc.de>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet> <20050114205651.GE17263@kam.mff.cuni.cz> <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com> <cs9v6f$3tj$1@terminus.zytor.com> <Pine.LNX.4.61.0501170909040.4593@ezer.homenet> <1105955608.6304.60.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0501171002190.4644@ezer.homenet> <41EBFF87.6080105@zytor.com> <m1wtubvm8y.fsf@muc.de> <41EC224D.5080204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC224D.5080204@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems like the unwinder should be running client-side, like it does on 
> kgdb.  Or does kdb not have a client at all?  (If so, I have no sympathy 
> for it.)

kdb runs 100% in the kernel.

-Andi
