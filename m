Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbWHNUIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWHNUIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWHNUIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:08:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58506
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932695AbWHNUIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:08:14 -0400
Date: Mon, 14 Aug 2006 13:08:14 -0700 (PDT)
Message-Id: <20060814.130814.126764626.davem@davemloft.net>
To: udovdh@xs4all.nl
Cc: linux-kernel@vger.kernel.org, folkert@vanheusden.com
Subject: Re: And another Oops / BUG? (2.6.17.7 on VIA Epia CL6000)
From: David Miller <davem@davemloft.net>
In-Reply-To: <44E096B4.9090207@xs4all.nl>
References: <44E096B4.9090207@xs4all.nl>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Udo van den Heuvel <udovdh@xs4all.nl>
Date: Mon, 14 Aug 2006 17:28:52 +0200

> Since 2.6.17.x my kernel Oopses every few days. Bewlo is the log.

Contact whoever you got this "pptp_gre.c" source file from.
It's not in the vanilla kernel, therefore we can't help you
debug the problem.

