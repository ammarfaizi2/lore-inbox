Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268460AbUHLIl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268460AbUHLIl0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 04:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUHLIl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 04:41:26 -0400
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:25049
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S268460AbUHLIlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 04:41:09 -0400
Message-ID: <411B2CC2.5020907@winischhofer.net>
Date: Thu, 12 Aug 2004 10:39:30 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




+	res->flags &= !PCI_ROM_COPY;

Erm....



-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org
