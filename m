Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267568AbUH0Ujd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267568AbUH0Ujd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUH0UiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:38:04 -0400
Received: from imap.gmx.net ([213.165.64.20]:30406 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267582AbUH0UfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:35:00 -0400
X-Authenticated: #494916
Message-ID: <412F9B16.7020706@gmx.de>
Date: Fri, 27 Aug 2004 22:35:34 +0200
From: Peter Schaefer <peter.schaefer@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [libata - SII3112] 'Virtual' bad blocks?
References: <412F8996.4020300@gmx.de> <412F8F93.2010008@pobox.com>
In-Reply-To: <412F8F93.2010008@pobox.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.08.2004 21:46, Jeff Garzik wrote:

> Alan Cox submitted code that makes the errors more specific, rather than 
> treating them all as disk errors.

Can i diff against libata-scsi.c in 2.9.1-rc1 to get this?

> You have either a flaky controller, flaky cable, or flaky disk, one of 
> the three.

Hrmpf. Well, i swapped cables as a first measure. I'll see if the error
travels with it (if not - well, there's still 4 years of guarantee on the
disk :).

Thanks alot for your support and your hard work on libata!

Best regards,

    Peter
