Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbUJ0GxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbUJ0GxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUJ0Gu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:50:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28902 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262261AbUJ0Gu2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:50:28 -0400
Message-ID: <417F4528.9030408@pobox.com>
Date: Wed, 27 Oct 2004 02:50:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Fedin <sonic_amiga@rambler.ru>
CC: linux-kernel@vger.kernel.org, luther@debian.org
Subject: Re: [PATCH] VIA8231 support for parallel port driver
References: <20041027093529.15ff1a31.sonic_amiga@rambler.ru>
In-Reply-To: <20041027093529.15ff1a31.sonic_amiga@rambler.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you consolidate it with the via 686 code?

Can you replace the magic numbers (0x3f0) with named constants?

	Jeff



