Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWGZTCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWGZTCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWGZTCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:02:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:687 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751763AbWGZTCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:02:15 -0400
Subject: Re: [2.6.18-rc2-gabb5a5cc BUG] Lukewarm IQ detected in hotplug
	locking
From: Arjan van de Ven <arjan@infradead.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607260801s73cdee9avd207984712011c80@mail.gmail.com>
References: <6bffcb0e0607251657w47697883n74bab2255fd44ece@mail.gmail.com>
	 <20060725181415.483838f5.pj@sgi.com>
	 <6bffcb0e0607260151i6065457g6acf9f4d9b2a6d50@mail.gmail.com>
	 <6bffcb0e0607260801s73cdee9avd207984712011c80@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 26 Jul 2006 21:02:12 +0200
Message-Id: <1153940532.3381.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 17:01 +0200, Michal Piotrowski wrote:
> Sorry for the noise.
> 
> The bug is fixed in latest git tree.


Hi,

no need to be sorry; it is a very valid bug, it's just something that
took some time to get fixed (and still isn't entirely done, my testbox
is busy rebooting to a next patch to fix another case).

I'm glad the patch that Linus merged about an hour or two ago fixes this
for you. Thanks for testing that!

Greetings,
   Arjan van de Ven


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

