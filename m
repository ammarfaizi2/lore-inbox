Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270993AbTHLRFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271007AbTHLRFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:05:22 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:58894 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S270993AbTHLRFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:05:18 -0400
From: Ian Hastie <lkml@ordinal.freeserve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re:
Date: Tue, 12 Aug 2003 18:05:15 +0100
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.56.0308121653281.8716@hosting.rdsbv.ro>
In-Reply-To: <Pine.LNX.4.56.0308121653281.8716@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308121805.16328.lkml@ordinal.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 Aug 2003 14:55, Catalin BOIE wrote:
> Hello!
>
> "cat drivers/built-in.o > /dev/null" gives me i/o error.
>
> Can I suspect a bad sector?
> I use reiserfs.

Can't say.  What i/o error does it give you?  Anything useful in 
/var/log/messages?  Or perhaps /var/log/kern.log?

-- 
Ian.

