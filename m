Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbTIQWEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 18:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbTIQWEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 18:04:22 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:65203 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S262840AbTIQWEV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 18:04:21 -0400
Date: Thu, 18 Sep 2003 00:04:15 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: James Simmons <jsimmons@infradead.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@redhat.com>, <mroos@linux.ee>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <Pine.LNX.4.44.0309172301200.1730-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0309180003160.8954-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Sep 2003, James Simmons wrote:

>
> > This is also a display fifo issue. I think you need to get the display
> > fifo code in the 2.4 driver, I have been working with Geert in May to get
> > exactly the problem resolved on his VAIO, a Dell laptop I had temporarily
> > then had the problem too, it was because of lack of precision. It's likely
> > that Alexander didn't update his code yet.
>
> Where is latest patches so I can intergate them into my Alex patch. Also
> please pass me the sparc fixes. Thanks.

(Driver sent to James in private mail, the others already have it.)

Daniël

