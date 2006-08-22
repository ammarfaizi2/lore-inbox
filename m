Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWHVTPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWHVTPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWHVTPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:15:01 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:27919 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751151AbWHVTO6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:14:58 -0400
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Herbert Xu's paged unique skb trimming patch?
References: <20060821184527.GA21938@kroah.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: because you deserve a brk today.
Date: Tue, 22 Aug 2006 20:13:23 +0100
In-Reply-To: <20060821184527.GA21938@kroah.com> (Greg KH's message of "21 Aug 2006 19:48:47 +0100")
Message-ID: <87d5asporw.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Aug 2006, Greg KH stipulated:
> Responses should be made by Wed, Auguest 23, 18:00:00 UTC.  Anything
> received after that time might be too late.

Dave Miller suggested that Herbert Xu's pskb trimming patch (commit
e9fa4f7bd291c29a785666e2fa5a9cf3241ee6c3) should go into -stable: did it
get lost? Without it, network stalls (at least) are quite possible.

-- 
scsi/atp870u.c: panic("Foooooooood fight!");
  --- linux-2.6.17/drivers/scsi/atp870u.c
