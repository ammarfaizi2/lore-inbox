Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUJSDb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUJSDb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 23:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUJSDb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 23:31:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29573 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267890AbUJSDb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 23:31:56 -0400
Message-ID: <41748A9D.2080306@pobox.com>
Date: Mon, 18 Oct 2004 23:31:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Haverkamp <markh@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Weird... 2.6.9 kills FC2 gcc
References: <4174697B.90306@pobox.com> <1098150587.1384.0.camel@peabody> <41747A28.2000101@pobox.com>
In-Reply-To: <41747A28.2000101@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More data points:

No problems at all on x86-64.

No ICE on 32-bit x86 gcc 3.4.2, with 2.6.9 release kernel.

So this ICE appears to be a bug specific to 3.3.x or perhaps Fedora.

	Jeff



