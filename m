Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVDMDXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVDMDXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVDMDTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 23:19:23 -0400
Received: from mail.aknet.ru ([217.67.122.194]:42504 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262177AbVDMDSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 23:18:18 -0400
Message-ID: <425C8F88.6090908@aknet.ru>
Date: Wed, 13 Apr 2005 07:18:32 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: petkov@uni-muenster.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3]: entry.S trap return fixes
References: <20050411012532.58593bc1.akpm@osdl.org>	<1113209793l.7664l.1l@werewolf.able.es>	<20050411024322.786b83de.akpm@osdl.org>	<200504112359.40487.petkov@uni-muenster.de>	<20050411152243.22835d96.akpm@osdl.org>	<425B4C92.1070507@aknet.ru>	<20050411212712.0dbd821d.akpm@osdl.org>	<425C25D3.7010703@aknet.ru> <20050412190940.066be192.akpm@osdl.org>
In-Reply-To: <20050412190940.066be192.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:
>> do_debug() returns void, do_int3() too when
> This patch is applicable to the mainline kernel, is it not?
I think so - with some offsets it applies
and looks valid.

