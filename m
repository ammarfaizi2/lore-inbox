Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUAXXPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUAXXPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 18:15:48 -0500
Received: from ozlabs.org ([203.10.76.45]:64994 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263101AbUAXXPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 18:15:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16402.64412.577682.141249@cargo.ozlabs.ibm.com>
Date: Sun, 25 Jan 2004 10:11:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Jeff Garzik <jgarzik@pobox.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] [2.4] forcedeth network driver
In-Reply-To: <20040124224635.GA3448@ucw.cz>
References: <4012BF44.9@colorfullife.com>
	<4012D3C6.1050805@pobox.com>
	<20040124220545.GA3246@ucw.cz>
	<4012F2B7.3080800@gmx.net>
	<20040124224635.GA3448@ucw.cz>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik writes:

> Well, my memory may be tricking me (I'm not really sure about this), but
> I remember there was supposed to be a PPC64 northbridge with a HT link,
> made exactly for the purpose of connecting an nForce southrbridge to it.
> But it definitely is not in production yet.

The U3 northbridge in the Apple G5 powermac has a HT link coming out
of it, which connects via an AMD PCI-X tunnel chip to an Apple K2
southbridge.  I have never heard of anyone using (or planning to use)
an nForce southbridge on a PPC64 system though.

Regards,
Paul.
