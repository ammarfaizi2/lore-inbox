Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269605AbUI3XIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269605AbUI3XIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269611AbUI3XIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:08:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52376 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269610AbUI3XIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:08:30 -0400
Message-ID: <415C91E0.7070005@pobox.com>
Date: Thu, 30 Sep 2004 19:08:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert mistakenly applied patch to sungem
References: <20040930100156.6012a290@pirandello>
In-Reply-To: <20040930100156.6012a290@pirandello>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Leroy wrote:
> Hi Andrew, everyone,
> 
> There's a mistake in 2.6.9-rc3, you applied a patch I sent yesterday,
> for something that was already implemented (netpoll support in sungem).
> 
> As Eric Lemoine and I didn't add the stuff at the same place, there has
> been no conflict.
> 
> See http://marc.theaimsgroup.com/?l=linux-kernel&m=109647405508937&w=2
> http://linux.bkbits.net:8080/linux-2.5/cset@4149f001_LtxxbZOVP8q363TiTcSVg
> http://linux.bkbits.net:8080/linux-2.5/cset@415b4276tcoFzDd1YSqq2ZJ_OkYlfQ
> 
> Following is the reverse patch to reverse my stuff :)
> Sorry about that.
> 
> Signed-off-by: Colin Leroy <colin@colino.net>

Andrew are you picking up this one?

	Jeff


