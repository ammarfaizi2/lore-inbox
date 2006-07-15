Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWGOTRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWGOTRa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 15:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWGOTRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 15:17:30 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:23766 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1030254AbWGOTR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 15:17:29 -0400
Subject: Re: Linux 2.6.17.5
From: Marcel Holtmann <marcel@holtmann.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e9bded$qco$1@news.cistron.nl>
References: <20060715030047.GC11167@kroah.com>
	 <Pine.LNX.4.64.0607142217020.5623@g5.osdl.org>
	 <44B8A720.3030309@gentoo.org> <44B90DF1.8070400@ns666.com>
	 <e9bded$qco$1@news.cistron.nl>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 21:17:51 +0200
Message-Id: <1152991071.12764.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

> >> I can confirm that the new fix prevents the exploit from working, with
> >> no immediately visible side effects.
> >
> >Can some one release a 2.6.17.6 ? I think many people are waiting at
> >their keyboard to get their systems protected.
> 
> # mount -o remount,nosuid /proc
> 
> Haven't tested it but that should be the workaround.

I did test it. And yes, it works.

Regards

Marcel


