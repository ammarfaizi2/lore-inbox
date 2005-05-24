Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVEXSW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVEXSW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVEXSW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:22:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:22992 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261935AbVEXSUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:20:47 -0400
Message-ID: <42937079.5010905@pobox.com>
Date: Tue, 24 May 2005 14:20:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Haumesser <chris@mail-test.us>
CC: kallol@nucleodyne.com, linux-kernel@vger.kernel.org
Subject: Re: promise sx8 sata driver
References: <42924E38.7070003@mail-test.us>  <42925F7F.2000809@pobox.com> <1116909972.15027.3.camel@driver> <42936BB8.3070903@mail-test.us>
In-Reply-To: <42936BB8.3070903@mail-test.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Haumesser wrote:
> I don't understand either.  The Promise driver (I think this is carmel?)
> found at
> http://www.promise.com/support/download/download2_eng.asp?productID=125&category=all&os=100#
> seems to be GPL.  I haven't tested it extensively yet, but it appears to
> provide scsi device nodes that grub recognizes readily.
> 
> Why are there two GPL driver projects for this card, and what is the
> difference?  Is there something wrong with promise's driver, or
> inherently superior in the kernel driver?  How is one supposed to
> choose?  There is very little documentation for either driver, so it is
> quite unclear which is appropriate for a given application.

Promise SX8 is not SCSI, and should not be a SCSI driver.

	Jeff



