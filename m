Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUJGIBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUJGIBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 04:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUJGIBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 04:01:21 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:58031 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S267335AbUJGIBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 04:01:21 -0400
Date: Thu, 7 Oct 2004 10:00:56 +0200
From: Sander <sander@humilis.net>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: "Johnson, Richard" <rjohnson@analogic.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.5-1.358 and Fedora
Message-ID: <20041007080056.GA10298@favonius>
Reply-To: sander@humilis.net
References: <Pine.LNX.4.53.0410051413520.3024@quark.analogic.com> <Pine.LNX.4.61.0410052100110.2913@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410052100110.2913@dragon.hygekrogen.localhost>
X-Uptime: 09:39:33 up 25 days, 30 min, 31 users,  load average: 0.86, 0.83, 0.82
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote (ao):
> Personally I prefer to manually
> # cp System.map /boot/System.map-<kernel-version>
> # cp arch/i386/boot/bzImage /boot/vmlinuz-<kernel-version>
> # ln -sf /boot/System.map-<kernel-version> /boot/System.map

I believe the symlink is not needed.
