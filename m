Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTKXOuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 09:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTKXOuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 09:50:10 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:51422 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263647AbTKXOuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 09:50:07 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 24 Nov 2003 14:42:12 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: video4linux-list@redhat.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test10] standby freezes bttv
Message-ID: <20031124134212.GE30618@bytesex.org>
References: <200311241420.08216.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311241420.08216.mbuesch@freenet.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nov 24 14:10:29 lfs kernel: bttv0: timeout: risc=1fd6601c, bits: VSYNC HSYNC OFLOW HLOCK VPRES RISCI
> Nov 24 14:10:29 lfs kernel: bttv0: reset, reinitialize

Does that still happen with the updates from bytesex.org/patches?

  Gerd

