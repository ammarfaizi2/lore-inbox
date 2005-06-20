Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVFTPUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVFTPUC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVFTPUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:20:01 -0400
Received: from smtpout1.BAYAREA.NET ([209.128.95.10]:33454 "EHLO
	smtpout1.bayarea.net") by vger.kernel.org with ESMTP
	id S261273AbVFTPTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:19:45 -0400
Message-ID: <42B6DE67.4050603@bayarea.net>
Date: Mon, 20 Jun 2005 16:19:03 +0100
From: Robert Gadsdon <rgadsdon@bayarea.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050415
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Robert Gadsdon <rgadsdon@bayarea.net>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12 kernel panic after loading promise_sata module
References: <42B68DFB.8090608@bayarea.net>
In-Reply-To: <42B68DFB.8090608@bayarea.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies. I had failed to notice that mkinitrd needed to be updated 
as well as udev..   Updated to version 4.2.16, and 2.6.12 boots OK.

Robert Gadsdon

Robert Gadsdon wrote:
> Tried 2.6.12 (vanilla) kernel, and had the following at boot:
> (typed from screen)
snip
> Starting udev
> Loading libata.ko module
> Loading sata_promise.ko module
> Creating root device
> Mounting root filesystem
> mount: error 6 mounting ext3

> 

