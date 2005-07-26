Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVGZCxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVGZCxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 22:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVGZCxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 22:53:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:63953 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261598AbVGZCxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 22:53:10 -0400
Subject: Re: supposed to be shared subtree patches.
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: akpm@osdl.org, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Avantika Mathur <mathurav@us.ibm.com>,
       Mike Waychison <mike@waychison.com>
In-Reply-To: <20050725224417.501066000@localhost>
References: <20050725224417.501066000@localhost>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1122346380.12074.133.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 25 Jul 2005 19:53:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-25 at 15:44, Ram Pai wrote:
> , miklos@szeredi.hu, Janak Desai <janak@us.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
> Subject: [PATCH 0/7] shared subtree
> 
> Hi Andrew/Al Viro,
> 
> 	Enclosing a final set of well tested patches that implement

....my apologies. I screwed up sending the patches through quilt.

anyway I have received the following comments from Andrew Morton, which
I will incorporate before sending out saner looking patches.
sorry again,
RP

Andrew's comments follows:
----------------------------------------

Frankly, I don't even know what these patches _do_, and haven't spent
the time to try to find out.

If these patches are merged, how do we expect end-users to find out how
to use the new capabilities?

A few paragraphs in the patch #1 changelog would help.  A high-level
description of the new capability which explains what it does and why it
would be a useful thing for Linux.

And maybe some deeper information in a Documentation/ file.

Right now, there might well be a lot of people who could use these new
features, but they don't even know that these patches provide them! 
It's all a bit of a mystery, really.
---------------------------------------------------------------------


