Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTFKJEK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTFKJEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:04:10 -0400
Received: from [217.222.53.238] ([217.222.53.238]:62993 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S264242AbTFKJEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:04:08 -0400
Message-ID: <3EE6F3B7.9040809@gts.it>
Date: Wed, 11 Jun 2003 11:17:43 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm8
References: <20030611013325.355a6184.akpm@digeo.com>
In-Reply-To: <20030611013325.355a6184.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm8/

arch/i386/kernel/setup.c: In function 'setup_early_printk':
arch/i386/kernel/setup.c:919: error: invalid lvalue in unary '&'
make[1]: *** [arch/i386/kernel/setup.o] Error 1

Bye

-- 
Stefano RIVOIR
GTS Srl



