Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269680AbUJGEB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269680AbUJGEB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 00:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269681AbUJGEB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 00:01:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64906 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269680AbUJGEBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 00:01:54 -0400
Message-ID: <4164BFA6.2070702@pobox.com>
Date: Thu, 07 Oct 2004 00:01:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: x86-64 config warning
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.9-rc3:

[...]
   UPD     include/linux/version.h
scripts/kconfig/conf -s arch/x86_64/Kconfig
Warning! Found recursive dependency: UNORDERED_IO UNORDERED_IO
#
