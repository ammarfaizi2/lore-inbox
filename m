Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbULEUbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbULEUbF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbULEUbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:31:05 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6345 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261380AbULEUbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:31:03 -0500
Subject: Re: [PATCH] Document kfree and vfree NULL usage (resend)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Manfred Spraul <manfred@colorfullife.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200412051313.22581.kernel-stuff@comcast.net>
References: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de>
	 <200412051244.36449.kernel-stuff@comcast.net>
	 <41B34C25.3060500@colorfullife.com>
	 <200412051313.22581.kernel-stuff@comcast.net>
Date: Sun, 05 Dec 2004 22:29:13 +0200
Message-Id: <1102278553.19406.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parag,

On Sun, 2004-12-05 at 13:12 -0500, Parag Warudkar wrote:
> Ok. So need for changing vmalloc() documentation then.
> 
> Here is the same previous patch inline instead of the attachment, with Signed-off-by -

Your patch conflicts with mine so it will not apply cleanly.
Furthermore, your mailer seems to throw in some control characters in
the mix and GNU patch does not like that.

		Pekka

