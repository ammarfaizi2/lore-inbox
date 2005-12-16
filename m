Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVLPSIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVLPSIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVLPSIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:08:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44441 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751336AbVLPSIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:08:34 -0500
Date: Fri, 16 Dec 2005 13:08:17 -0500
From: Dave Jones <davej@redhat.com>
To: 7eggert@gmx.de
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Alex Davis <alex14641@yahoo.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216180816.GC2821@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, 7eggert@gmx.de,
	Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
	Alex Davis <alex14641@yahoo.com>
References: <5kh6K-7KC-3@gated-at.bofh.it> <5kiFR-1mi-11@gated-at.bofh.it> <E1EnDOo-0006Gd-Na@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EnDOo-0006Gd-Na@be1.lrz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 12:05:18PM +0100, Bodo Eggert wrote:

 > ACK. So where is the driver for the Netgear WG511 Softmac card I'm supposed
 > to test? I bought this card because it was labled as being supported, and it
 > turned out that it wasn't, and just nobody cared to update the list of
 > supported cards with the warning about the unsupported variant.

There are two models of that card with the same name.
The one made in taiwan is a prism54, the one made in china is
something else.  I guess yours is made in China ?

		Dave

