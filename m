Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVCCUEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVCCUEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVCCUBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:01:13 -0500
Received: from khc.piap.pl ([195.187.100.11]:54788 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261961AbVCCT5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:57:08 -0500
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       davem@davemloft.net, jgarzik@pobox.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org>
	<42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<20050303011151.GJ10124@redhat.com>
	<20050302172049.72a0037f.akpm@osdl.org>
	<20050303012707.GK10124@redhat.com>
	<20050303145846.GA5586@pclin040.win.tue.nl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 03 Mar 2005 20:55:15 +0100
In-Reply-To: <20050303145846.GA5586@pclin040.win.tue.nl> (Andries Brouwer's
 message of "Thu, 3 Mar 2005 15:58:46 +0100")
Message-ID: <m3r7iwv718.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

> API stability: Stable series like 2.0, 2.2, 2.4 try to maintain
> the guarantee that user-visible APIs do not change. That goal
> has disappeared, meaning that anything might break when one
> upgrades from 2.6.14 to 2.6.16.

Both 2.4 and 2.6 are IMHO similar. There were API changes in 2.4,
and in 2.6 they should be discouraged exactly as in 2.4.
-- 
Krzysztof Halasa
