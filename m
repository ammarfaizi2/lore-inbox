Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUBNS6n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 13:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUBNS6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 13:58:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50868 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262888AbUBNS6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 13:58:42 -0500
Message-ID: <402E6FD5.6070809@pobox.com>
Date: Sat, 14 Feb 2004 13:58:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@yahoo.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: libata patch
References: <20040214160254.19491.qmail@web14902.mail.yahoo.com>
In-Reply-To: <20040214160254.19491.qmail@web14902.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> The latest 2.6 bk libata patch took my box down. It's a Dell PE400SC, 82801EB
> ICH5, SATA drives. It works for a little while then I get DMA errors, then I
> freeze.
> It had been working fine on 2.6 for months.


da, backing it out...

	Jeff



