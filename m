Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTGXMyH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 08:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTGXMyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 08:54:07 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:27912 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263861AbTGXMyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 08:54:06 -0400
Subject: Re: 2.6.0-test1-mm2 ext3-related OOPS while running tar
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87adb4hwde.fsf@gw.home.net>
References: <1059038117.577.23.camel@teapot.felipe-alfaro.com>
	 <87adb4hwde.fsf@gw.home.net>
Content-Type: text/plain
Message-Id: <1059052151.577.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 24 Jul 2003 15:09:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-24 at 15:45, Alex Tomas wrote:

> please, try this patch

Well, at least with your patch applied I can't reproduce the previous
oops while untarring the kernel sources. I'm going to use
2.6.0-test1-mm2 with your patch as my main kernel and will see if the
oops is gone forever.

Thanks! :-)

