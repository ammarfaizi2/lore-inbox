Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTJ1CNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 21:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTJ1CNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 21:13:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36813 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261506AbTJ1CNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 21:13:20 -0500
Message-ID: <3F9DD0A6.1010703@pobox.com>
Date: Mon, 27 Oct 2003 21:12:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test9
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org> <20031026120521.GD32168@vic20.blipp.com> <20031027182141.GH32168@vic20.blipp.com> <bnk7ha$lqi$1@gatekeeper.tmr.com>
In-Reply-To: <bnk7ha$lqi$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> In article <20031027182141.GH32168@vic20.blipp.com>,
> Patrik Wallstrom  <pawal@blipp.com> wrote:
> 
> | This patch worked for the Promise-controller:
> | http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-promise20378.patch
> 
> If this patch solves the problem, might I hope that it will be
> considered critical enough a bugfix to get into the mainline? I assume
> the SATA code added in test9 was intended to work, rather than as a
> place holder.


The above patch solves the 'problem' of a particular PCI id not being 
listed in the driver.

IOW it _adds_ new hardware support.

	Jeff



