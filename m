Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTHZPGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTHZPGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:06:17 -0400
Received: from gw-nl6.philips.com ([212.153.235.103]:35272 "EHLO
	gw-nl6.philips.com") by vger.kernel.org with ESMTP id S262868AbTHZPFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:05:23 -0400
Message-ID: <3F4B777E.50807@basmevissen.nl>
Date: Tue, 26 Aug 2003 17:06:38 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.xx and configuring PCMCIA cards without cardutils
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For a small computer, I want to use PCMCIA compiled into the kernel. I 
only have 1 network card (fixed) in a PCMCIA slot. The kernel should 
boot (from disk) with a NFS root. Because I want to keep things as small 
as possible, I want to go without an initrd with cardutils.

So I'm wondering how to configure the network card from kernel space, if 
possible at all.

Regards,

Bas.



