Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUJPVt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUJPVt0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268904AbUJPVtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:49:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37047 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268899AbUJPVqf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:46:35 -0400
Message-ID: <417196AA.3090207@pobox.com>
Date: Sat, 16 Oct 2004 17:46:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>
In-Reply-To: <41719537.1080505@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only really notable changes in -bk3 -> -bk4 are the signal changes, 
something in mm/vmscan.c.

	Jeff



