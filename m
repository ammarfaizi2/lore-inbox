Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTLRHXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 02:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTLRHXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 02:23:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38866 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263653AbTLRHX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 02:23:29 -0500
Message-ID: <3FE155E4.5080502@pobox.com>
Date: Thu, 18 Dec 2003 02:23:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [I810_AUDIO] 1/x: Fix wait queue race in drain_dac
References: <20031122070931.GA27231@gondor.apana.org.au>
In-Reply-To: <20031122070931.GA27231@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert,

Just wanted to 'ack' your i810_audio patches.  I think Alan stuck me 
with i810_audio ("you last touched it, you're it") so I'll look over and 
merge your patches into 2.4.x and 2.6.x.

i810_audio also needs to be MMIO-ized, which will be a simple but 
staggeringly huge change...

	Jeff




