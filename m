Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266757AbUAWXab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUAWX3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:29:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58045 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266757AbUAWX33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:29:29 -0500
Message-ID: <4011AE4C.5050408@pobox.com>
Date: Fri, 23 Jan 2004 18:29:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mgabriel@ecology.uni-kiel.de
CC: linux-kernel@vger.kernel.org
Subject: Re: vt6410 in kernel 2.6
References: <200401222238.09157.mgabriel@ecology.uni-kiel.de>
In-Reply-To: <200401222238.09157.mgabriel@ecology.uni-kiel.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Gabriel wrote:
> hi there,
> 
> is there any chance of upcoming support for the vt6410 ide/raid chipset in the 
> 2.6.x kernel? there has been an attempt by via itself, but it only suits 
> redhat 7.2 kernels and systems, thus it is highly specific. is there any1 who 
> is working on that?


It should already be in there.

Note that it is not really RAID...  just software RAID.

	Jeff



