Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUFNFcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUFNFcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 01:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUFNFcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 01:32:41 -0400
Received: from mailout.despammed.com ([65.112.71.29]:47065 "EHLO
	mailout.despammed.com") by vger.kernel.org with ESMTP
	id S261932AbUFNFck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 01:32:40 -0400
Date: Mon, 14 Jun 2004 00:19:15 -0500 (CDT)
Message-Id: <200406140519.i5E5JEk23773@mailout.despammed.com>
From: ndiamond@despammed.com
To: linux-kernel@vger.kernel.org
Subject: Re: Panics need better handling
X-Mailer: despammed.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau replied to me:

>> Is there
>> any chance in getting the 24 most
>> important lines of panic information
>> displayed last, and putting the cursor
>> at the end of the 24th line thereof, so
>> that 24 valuable lines of panic
>> information can be visible?
>
> You could try kmsgdump, which Randy Dunlap ported to 2.6
[...]
> Clearly what you need it seems,

Partly, yes it looks clearly what I
need (though I need it for 2.4).

But surely every developer or maintainer
of every driver or other part of the
kernel also has a clear need for every
Linux user to install this.  I am not
the only one who needs to get these
reports, right?  Shouldn't this be in
the main kernel tree by now, and enabled
by default?

