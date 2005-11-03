Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbVKCDzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbVKCDzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbVKCDzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:55:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751598AbVKCDzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:55:18 -0500
Date: Thu, 3 Nov 2005 13:55:04 +1100
From: Andrew Morton <akpm@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH 21/37] dvb: Add support for Air2PC/AirStar 2 ATSC 3rd
 generation (HD5000)
Message-Id: <20051103135504.1dfa2db1.akpm@osdl.org>
In-Reply-To: <436723F8.4000602@m1k.net>
References: <436723F8.4000602@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> +			return -EREMOTEIO;

That's the first time I've seen anyone use EREMOTEIO ;) Any idea what it
was added to Unix for?

hm, DVB seems to like it.
