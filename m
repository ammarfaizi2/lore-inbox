Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269184AbRHFXxp>; Mon, 6 Aug 2001 19:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269187AbRHFXxf>; Mon, 6 Aug 2001 19:53:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41480 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269184AbRHFXxX>; Mon, 6 Aug 2001 19:53:23 -0400
Subject: Re: [PATCH] one of $BIGNUM devfs races
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Tue, 7 Aug 2001 00:54:04 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Richard Gooch" at Aug 06, 2001 05:50:46 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TuCC-00021i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus: please don't apply.
> Alan: I notice you've put Al's patch into 2.4.7-ac8. Please remove it.

I'll remove it when your preferred fixes are ready. Until then its better
than leaving it broken.

