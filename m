Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTJCI5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTJCI5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:57:47 -0400
Received: from dyn-ctb-203-221-73-69.webone.com.au ([203.221.73.69]:61451 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263647AbTJCI5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:57:46 -0400
Message-ID: <3F7D3A05.50807@cyberone.com.au>
Date: Fri, 03 Oct 2003 18:57:41 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rodolfo Boer <movez@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Badness in as_remove_dispatched_request
References: <200310031013.37366.movez@gawab.com> <200310031054.09227.movez@gawab.com>
In-Reply-To: <200310031054.09227.movez@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rodolfo Boer wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Alle 10:13, venerdì 3 ottobre 2003, Rodolfo Boer ha scritto:
>
>>Hello! This is my first try with the 2.6.0-test kernels and I get AMOUNTS
>>of these warnings during boot-up on both test5 and test6 (this expecially
>>is from test6):
>>
>I'm sorry, I forgot half the mail.
>This happens with tagged command queing enabled, which should be supported by
>my Deskstar 180GXP.
>

Well, give the latest cset a try anyway, and let me know what you get.
I think TCQ for IDE is not very stable at the moment.


