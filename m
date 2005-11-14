Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVKNSjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVKNSjI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVKNSjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:39:08 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:9386 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751230AbVKNSjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:39:06 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 14 Nov 2005 18:38:57 +0000
User-Agent: KMail/1.9
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <200511141822.31315.s0348365@sms.ed.ac.uk> <1131992968.2821.50.camel@laptopd505.fenrus.org>
In-Reply-To: <1131992968.2821.50.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511141838.57108.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 November 2005 18:29, Arjan van de Ven wrote:
> > LWN has a piece on the possible options, but I suppose you could use the
> > argument that forcibly breaking ndiswrapper will spur new driver
> > development (but if you look at vendors like Broadcom, they have seem
> > consistently unwilling to do this).
>
> there now is a specification for the broadcom wireless, and a driver is
> being written right now to that specification; and it seems to be
> getting along quite well (it's not ready for primetime use yet but at
> least they can send and receive stuff, which is probably the hardest
> part)

Great news. Perhaps all is not lost. This seems to be a leading chip for 
laptop wireless, which is an especially contentious issue (since users cannot 
swap it out as easily due to BIOS locks).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
