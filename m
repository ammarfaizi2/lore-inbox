Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTDNTWn (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTDNTWn (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:22:43 -0400
Received: from golf.rb.xcalibre.co.uk ([217.8.240.16]:18447 "EHLO
	golf.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S263937AbTDNTWm (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:22:42 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
To: Greg KH <greg@kroah.com>, Robert Love <rml@tech9.net>
Subject: Re: 2.5.67-mm2
Date: Mon, 14 Apr 2003 20:33:46 +0100
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <200304132059.11503.alistair@devzero.co.uk> <20030414004926.GA23762@kroah.com> <20030414182127.GD4112@kroah.com>
In-Reply-To: <20030414182127.GD4112@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304142033.46351.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 19:21, Greg KH wrote:
> On Sun, Apr 13, 2003 at 05:49:26PM -0700, Greg KH wrote:
> > I'll work on fixing this up on Monday...
>
> David Miller pointed out the proper fix, and here it is.  Let me know
> if this works for everyone or not.

Patching 2.5.67 to -mm3, then reverting Andrew's workaround and applying 
your fix still allows me to boot. Therefore it is fixed, here.

Cheers,
Alistair.

