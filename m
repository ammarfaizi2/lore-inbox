Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268237AbUHQODy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268237AbUHQODy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUHQODy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:03:54 -0400
Received: from apollo.tuxdriver.com ([24.172.12.4]:19728 "EHLO
	ra.tuxdriver.com") by vger.kernel.org with ESMTP id S268237AbUHQODv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:03:51 -0400
Message-ID: <41221036.2020701@tuxdriver.com>
Date: Tue, 17 Aug 2004 10:03:34 -0400
From: "John W. Linville" <linville@tuxdriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dev_null@anet.ne.jp
CC: davem@redhat.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27
References: <20040817110002.32088.38168.Mailman@linux.us.dell.com> <200408172129.AJH50391.692B5188@anet.ne.jp>
In-Reply-To: <200408172129.AJH50391.692B5188@anet.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa wrote:

> I compiled as a UP kernel but it wasn't the cause.
> Also, I patched the above fix on 2.4.27-rc4 and
> compiled as a UP kernel, but didn't work.
> 

Testsuo,

Please send the output of `lspci -vv`.  It might be helpful to know 
exactly which device is involved.

David,

FWIW, I think I'm seeing the same problem with the BCM5751 built-in to 
my HP xw4200...

John
