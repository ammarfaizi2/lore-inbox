Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267969AbUHKLIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267969AbUHKLIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 07:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267970AbUHKLIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 07:08:10 -0400
Received: from CPE-65-30-20-102.kc.rr.com ([65.30.20.102]:40849 "EHLO
	mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S267969AbUHKLII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 07:08:08 -0400
Message-ID: <44852.192.168.1.12.1092222487.squirrel@192.168.1.12>
In-Reply-To: <20040810135409.44d31d1e@lembas.zaitcev.lan>
References: <1092142777.1042.30.camel@bart.intern>
    <20040810171000.GC12702@logos.cnet>
    <mailman.1092163681.21436.linux-kernel2news@redhat.com>
    <20040810135409.44d31d1e@lembas.zaitcev.lan>
Date: Wed, 11 Aug 2004 06:08:07 -0500 (CDT)
Subject: Re: uhci-hcd oops with 2.4.27/ intel D845GLVA
From: "Nick Bartos" <spam99@2thebatcave.com>
To: "Pete Zaitcev" <zaitcev@redhat.com>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, km@westend.com, david-b@pacbell.net
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The "uhci-hcd in 2.4.27" was launched by Nick, Kai simply reused that
> header. I should note when I saw "uhci-hcd" I automatically ignored it,
> because there's no uhci-hcd in 2.4.

sorry about the incorrect subject, I was in a hurry to get to work...

In any event now the kernel will boot fine.  I haven't really tested the
usb, but of course the really important thing is that the kernel doesn't
crash :)


