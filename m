Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbULROVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbULROVI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 09:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbULROVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 09:21:07 -0500
Received: from coderock.org ([193.77.147.115]:40121 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261163AbULROUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 09:20:54 -0500
Date: Sat, 18 Dec 2004 15:20:58 +0100
From: Domen Puncer <domen@coderock.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usbdevfs mount failure with 2.6.10-rc3
Message-ID: <20041218142058.GA11628@nd47.coderock.org>
References: <04I4WDU12@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04I4WDU12@server5.heliogroup.fr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/04 13:34 +0000, Hubert Tonneau wrote:
> With 2.6.10-rc3 I get ENODEV error when trying to mount usbdevfs
> No problem with 2.6.9

Try mounting usbfs, usbdevfs was deleted.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
