Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUBXBE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUBXBE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:04:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27840 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262120AbUBXBE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:04:57 -0500
Message-ID: <403AA30A.2090601@pobox.com>
Date: Mon, 23 Feb 2004 20:04:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mipam <mipam@ibb.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: broadcom bcm5703 support in 2.6.3?
References: <Pine.LNX.4.33.0402231043430.30027-100000@ux1.ibb.net>
In-Reply-To: <Pine.LNX.4.33.0402231043430.30027-100000@ux1.ibb.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mipam wrote:
> And in here i only see broadcom tigon3 support

> Where should i be in the config of the kernel to enable bcm5703 support?


CONFIG_TIGON3

	Jeff



