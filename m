Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUDICxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 22:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUDICxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 22:53:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36515 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262389AbUDICxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 22:53:33 -0400
Message-ID: <4076101F.1090601@pobox.com>
Date: Thu, 08 Apr 2004 22:53:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: martin f krafft <madduck@madduck.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Promise PDC 20375
References: <20040409022458.GA7081@diamond.madduck.net>
In-Reply-To: <20040409022458.GA7081@diamond.madduck.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

martin f krafft wrote:
> I was sold a Promise PDC 20375 IDE Controller for use with
> a parallel ATA drive today. The guy said that Linux just started to
> support it. However, I can only find 202xx related drivers in the
> kernel, and they do not detect the 20375 controller.
> 
> Can I use this controller with Linux, or should I return it?

Use kernel 2.6.x or download the patch for 2.4.x at the URL below or buy 
a recent Linux distribution from a vendor.

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/

	Jeff



