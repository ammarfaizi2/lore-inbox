Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbUKGNFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUKGNFO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 08:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUKGNFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 08:05:13 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:60124 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261608AbUKGNFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 08:05:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=V8E8eCmbeBjTDRiaGzE6TAZFLDg7UPmFhRwU1aP6S53kP8WlPIoO16frXTSqqoq1uwQMDJEgB+LvfDp1p3GOb8vapTyWZCTWjILCw/x98zTpDDSsRBe+VjZu7+3hR/4XRqsvVz37jHC8xu91Eld/y6qnvhjl/Cc/UZ+JphGqsIo=
Message-ID: <84144f020411070505627bc4fb@mail.gmail.com>
Date: Sun, 7 Nov 2004 15:05:07 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Christian Kujau <evil@g-house.de>
Subject: Re: Oops in 2.6.10-rc1
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net,
       perex@suse.cz, penberg@cs.helsinki.fi
In-Reply-To: <418D7959.4020206@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4180F026.9090302@g-house.de>
	 <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
	 <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de>
	 <418D7959.4020206@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Sun, 07 Nov 2004 02:24:41 +0100, Christian Kujau <evil@g-house.de> wrote:
> if someone could give me a hint here what to do next or perhaps tell me
> that the whole things was totally pointless - please say so.
> i am somehow lost as to which is the right person to bug here.

I am running 2.6.10-rc1-bk14 with ens-1371 working ok. Could you
please post your .config so I can try to reproduce your oops?

               Pekka
