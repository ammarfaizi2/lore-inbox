Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbTJNR7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbTJNR7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:59:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33726 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262611AbTJNR7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:59:21 -0400
Message-ID: <3F8C3965.6020005@pobox.com>
Date: Tue, 14 Oct 2003 13:59:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
CC: linux-parport@torque.net, linux-kernel@vger.kernel.org,
       Tim Waugh <twaugh@redhat.com>
Subject: Re: [PATCH] Fix broken superio DMA support in parport_pc.c
References: <XFMail.20031011175859.f.duncan.m.haldane@worldnet.att.net>
In-Reply-To: <XFMail.20031011175859.f.duncan.m.haldane@worldnet.att.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks good to me, but your patch did not apply.

Can you please download the latest 2.4 and 2.6 snapshots, and create 
patches versus those kernels?

ftp://ftp.kernel.org/pub/linux/kernel/v2.[46]/snapshots/

Also, please send patches, uncompressed, in separate emails.  i.e. one 
for 2.4, and one for 2.6.

