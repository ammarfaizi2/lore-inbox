Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266134AbUGOHMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUGOHMI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 03:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUGOHMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 03:12:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.173]:31449 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266134AbUGOHMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 03:12:06 -0400
To: =?iso-8859-1?Q?William_Lee_Irwin_III?= <wli@holomorphy.com>
Subject: =?iso-8859-1?Q?Re:_Re:_[PATCH]_was:_[RFC]_removal_of_sync_in_panic?=
From: <linux-kernel@borntraeger.net>
Cc: <linux-kernel@vger.kernel.org>,
       =?iso-8859-1?Q?Andrew_Morton?= <akpm@osdl.org>, <lmb@suse.de>
Message-Id: <5636222$108987528740f62d57f21052.04964585@config20.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 5636222
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Thu, 15 Jul 2004 09:10:01 +0200
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.147
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


William Lee Irwin III <wli@holomorphy.com> schrieb am 15.07.2004, 

>I've seen SMP boxen run interrupt handlers for ages after panicking,
> but I never thought much of it.

I have seen more than just interupt handlers.I was able to log in via
ssh. After typing dmesg I saw 2 panics and the system was still up.
