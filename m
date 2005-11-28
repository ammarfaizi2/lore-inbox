Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVK1OKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVK1OKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 09:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVK1OKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 09:10:15 -0500
Received: from attila.bofh.it ([213.92.8.2]:57292 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S1751262AbVK1OKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 09:10:14 -0500
Date: Mon, 28 Nov 2005 15:10:03 +0100
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: saa7134 broken in 2.6.15-rc2
Message-ID: <20051128141003.GA4806@wonderland.linux.it>
References: <20051128135254.GA4218@wonderland.linux.it> <200511281501.32949.duncan.sands@math.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511281501.32949.duncan.sands@math.u-psud.fr>
User-Agent: Mutt/1.5.11
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:

> There seems to be something rotten in v4l land; here's one I got with 2.6.15-rc1-git1
Yes, I should have STFW better: http://lkml.org/lkml/fancy/2005/11/24/194 .

video-buf is still broken for me in -rc2, I can make xawtv work if I set
capture to "overlay", but it still complain about no input sources other
than "default".

-- 
ciao,
Marco
