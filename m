Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266777AbUHROwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266777AbUHROwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 10:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266806AbUHROwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 10:52:31 -0400
Received: from memebeam.org ([212.13.199.71]:50188 "EHLO jvb.vm.bytemark.co.uk")
	by vger.kernel.org with ESMTP id S266777AbUHROw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 10:52:28 -0400
Message-ID: <41236D27.1080804@neggie.net>
Date: Wed, 18 Aug 2004 10:52:23 -0400
From: John Belmonte <john@neggie.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Hiroshi Miura <miura@da-cha.org>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       letsnote-tech@ml.good-day.co.jp
Subject: Re: [PATCH][ACPI] Panasonic Hotkey Driver
References: <87d62cxnud.wl%miura@da-cha.org> <1092805474.25902.126.camel@dhcppc4>
In-Reply-To: <1092805474.25902.126.camel@dhcppc4>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> Ah yes, another battle in the war on hot-keys;-)
> 
> On Sat, 2004-07-31 at 10:17, Hiroshi Miura wrote:
> 
>>+/*
>>+ *  Panasonic HotKey control Extra driver
>>+ *  (C) 2004 Hiroshi Miura <miura@da-cha.org>
>>+ *  (C) 2004 NTT DATA Intellilink Co. http://www.intellilink.co.jp/
>>+ *  All Rights Reserved
>>+ *
>>+ *  This program is free software; you can redistribute it and/or
>>modify
>>+ *  it under the terms of the GNU General Public License version 2 as
>>+ *  publicshed by the Free Software Foundation.
>>+ *
>>+ *  This program is distributed in the hope that it will be useful,
>>+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>+ *  GNU General Public License for more details.
>>+ * *  You should have received a copy of the GNU General Public
>>License
>>+ *  along with this program; if not, write to the Free Software
>>+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
>>02111-1307  USA
>>+ *
>>+ *  The devolpment page for this driver will be located at
>>+ *  http://www.da-cha.org/
>>+ *
>>+
>>*---------------------------------------------------------------------------
>>+ *
>>+ * ChangeLog:
>>+ *     Jul.25, 2004    Hiroshi Miura <miura@da-cha.org>
>>+ *             - v0.4  first post version
>>+ *             -       add debug function to retrive SIFR
>>+ *
>>+ *     Jul.24, 2004    Hiroshi Miura <miura@da-cha.org>
>>+ *             - v0.3  get proper status of hotkey
>>+ *
>>+ *      Jul.22, 2004   Hiroshi Miura <miura@da-cha.org>
>>+ *             - v0.2  add HotKey handler
>>+ *
>>+ *      Jul.17, 2004   Hiroshi Miura <miura@da-cha.org>
>>+ *             - v0.1  based on acpi video driver
>>+ *
> 
> 
> would be polite to credit the exact files that you leveraged.

I think it's a little beyond a politeness issue.  Large verbatim blocks 
of toshiba_acpi.c are used, with my copyright notice nowhere in sight.

-John


-- 
http://giftfile.org/  ::  giftfile project
