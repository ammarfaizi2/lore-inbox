Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268698AbUH3RsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268698AbUH3RsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268695AbUH3RrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:47:05 -0400
Received: from colin2.muc.de ([193.149.48.15]:22287 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268681AbUH3RpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:45:23 -0400
Date: 30 Aug 2004 19:45:22 +0200
Date: Mon, 30 Aug 2004 19:45:22 +0200
From: Andi Kleen <ak@muc.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       mark.langsdorf@amd.com
Subject: Re: Celistica with AMD chip-set
Message-ID: <20040830174522.GA59551@muc.de>
References: <2yV1c-29L-7@gated-at.bofh.it> <2yVb1-2ft-57@gated-at.bofh.it> <m34qmktzlk.fsf@averell.firstfloor.org> <Pine.LNX.4.53.0408301318290.22149@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0408301318290.22149@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is NOT "blindly" overwritten. We know what was in that register
> (0x2c01).

You don't, it depends on the BIOS version and the hardware revision.

-Andi
