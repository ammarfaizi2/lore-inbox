Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWCCPQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWCCPQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWCCPQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:16:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58373 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932072AbWCCPQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:16:45 -0500
Date: Fri, 3 Mar 2006 15:10:23 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Koen Martens <linuxarm@metro.cx>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/14] s3c2412/s3c2413 support
Message-ID: <20060303151023.GB2580@ucw.cz>
References: <44082001.9090308@metro.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44082001.9090308@metro.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-03-06 11:52:49, Koen Martens wrote:
> This patchset adds various defines and bits for the 
> s3c2412 and s3c2413
> processors, as well as adding detection of this cpu to 
> platform setup and
> uncompress boot stage.
> The changes should not disturb current s3c24xx 
> implementations. The
> patchset is preliminary, in that the final datasheet is 
> not yet available. We
> did some testing of these new registers and bits outside 
> of the linux
> kernel.

Ahha, it is actually arm derivative. Still it would be nice to have
better name.

> 
> -- 
> K.F.J. Martens, Sonologic, http://www.sonologic.nl/
> Networking, hosting, embedded systems, unix, artificial 
> intelligence.
> Public PGP key: http://www.metro.cx/pubkey-gmc.asc
> Wondering about the funny attachment your mail program
> can't read? Visit http://www.openpgp.org/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Thanks, Sharp!
