Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVISOYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVISOYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 10:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVISOYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 10:24:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56264 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932428AbVISOYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 10:24:12 -0400
Date: Mon, 19 Sep 2005 16:24:09 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Remove URB_ASYNC_UNLINK from last patch
Message-ID: <20050919142409.GB2959@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20050919141037.GB13054@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050919141037.GB13054@pingi3.kke.suse.de>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 04:10:37PM +0200, Karsten Keil wrote:
> 
> Sorry, tested the wrong HEAD for compile.
> 
> - usb_unlink_urb is always async now, so URB_ASYNC_UNLINK was removed from
>   core USB and we must do as well.
> 
> Signed-off-by: Karsten Keil <kkeil@suse.de>
> 

Is here a way in git to "merge" these two patches ?

-- 
Karsten Keil
SuSE Labs
ISDN development
