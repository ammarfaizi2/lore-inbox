Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbUDZQK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUDZQK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUDZQKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:10:14 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:48029 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262923AbUDZQKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:10:07 -0400
Date: Mon, 26 Apr 2004 18:10:04 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Anyone got aic7xxx working with 2.4.26?
Message-ID: <20040426161004.GE5430@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200404261532.37860.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404261532.37860.dj@david-web.co.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004, David Johnson wrote:

> I was wondering if anyone had aic7xxx SCSI working with kernel 2.4.26?

I've seen bogus and fruitless bus and host adaptor resets at kernel-boot
with sym53c8xx_2 with a recent 2.4-BK (the last that I could compile, I
cannot compile the current 2.4 BK tree at all for unknown reasons. 2.6
is fine), i386.

> I've also got the same problem with 2.6.5 (and newer) - but I think this is a 
> known issue with 2.6?

Not using aic7xxx on 2.6, 2.6.6-rc2 is fine for me.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
