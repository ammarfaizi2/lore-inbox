Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVBBAGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVBBAGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 19:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVBBAGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 19:06:41 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:49931 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S262209AbVBBAGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 19:06:34 -0500
Message-ID: <42001A47.40409@gentoo.org>
Date: Wed, 02 Feb 2005 00:09:43 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel-janitors@osdl.org, kernel list <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org, benh@kernel.crashing.org
Subject: Re: driver model u32 -> pm_message_t conversion: help needed
References: <20050125194710.GA1711@elf.ucw.cz>
In-Reply-To: <20050125194710.GA1711@elf.ucw.cz>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Cw82S-000L5D-Hf*i43NMcVAE4Q*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Pavel Machek wrote:
> Now, if you want to help, just convert some drivers... To quickly
> break compilation in case of bad types, following patch can be used
> (against 2.6.11-rc2-mm1), it actually switches pm_message_t to
> typedef.
> 
> I'm looking forward to the patches, (please help),

I just had a look at converting some but then found some identical patches 
written by you elsewhere. Are there any remaining conversions to be done? 
Perhaps you could post some grep output from your local tree if there are?

Thanks,
Daniel
