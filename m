Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTIQWCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 18:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTIQWCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 18:02:08 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:38408 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262853AbTIQWCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 18:02:07 -0400
Date: Wed, 17 Sep 2003 23:02:03 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@redhat.com>, <mroos@linux.ee>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <Pine.LNX.4.44.0309172350080.8954-100000@deadlock.et.tudelft.nl>
Message-ID: <Pine.LNX.4.44.0309172301200.1730-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is also a display fifo issue. I think you need to get the display
> fifo code in the 2.4 driver, I have been working with Geert in May to get
> exactly the problem resolved on his VAIO, a Dell laptop I had temporarily
> then had the problem too, it was because of lack of precision. It's likely
> that Alexander didn't update his code yet.

Where is latest patches so I can intergate them into my Alex patch. Also 
please pass me the sparc fixes. Thanks.


