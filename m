Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbUJ0T53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbUJ0T53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbUJ0Tyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:54:41 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:13472 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S262632AbUJ0Txf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:53:35 -0400
Date: Wed, 27 Oct 2004 15:50:28 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: My thoughts on the "new development model"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <200410271553_MC3-1-8D4F-38E7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 at 16:27 +0100 Alan Cox wrote:

> You missed the remote DoS attack 8(

  Where?


>>   - i8042 fails to initialize with some boards using legacy USB
>
> This is really a BIOS issue and its not a new 2.6.9 bug its a long
> standing and messy story.

  And the patch in -ac fixes it but there is a cleaner one around
that does it more properly, right?


--Chuck Ebbert  27-Oct-04  15:35:39
