Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266158AbUGESGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUGESGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbUGESGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:06:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64678 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266158AbUGESGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:06:45 -0400
Message-ID: <40E998A7.3060907@pobox.com>
Date: Mon, 05 Jul 2004 14:06:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EDD results (was Re: Weird:  30 sec delay during early boot)
References: <Pine.LNX.4.44.0407050827200.30783-100000@humbolt.us.dell.com> <40E99815.6080609@pobox.com>
In-Reply-To: <40E99815.6080609@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Second report, the one with the 30-second delay:
> MSI whitebox, VIA-based, Athlon64
> Promise 203xx SATA (boot drive)
> VIA SATA

This box also has VIA PATA, but I have disabled the controller in BIOS. 
  Also, nothing is connected to the PATA controller.

(I'm guessing this detail may be related to the delay)

