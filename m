Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTKPSXN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 13:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTKPSXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 13:23:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32431 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263088AbTKPSXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 13:23:11 -0500
Message-ID: <3FB7C077.6080204@pobox.com>
Date: Sun, 16 Nov 2003 13:22:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: Carrier detection for network interfaces
References: <1068912989.5033.32.camel@nosferatu.lan> <3FB652BA.1010905@pobox.com> <20031116131550.GD7650@merlin.emma.line.org>
In-Reply-To: <20031116131550.GD7650@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> Whatever linkwatch is (can't find it with Google and freshmeat quickly).

Using netlink for link notification.


> For 3c59x, neither mii-tool nor ethtool work with 2.6, only mii-diag
> will do.


You need an updated mii-tool.

	Jeff



