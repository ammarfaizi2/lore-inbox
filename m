Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268770AbTBZO5F>; Wed, 26 Feb 2003 09:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268771AbTBZO5F>; Wed, 26 Feb 2003 09:57:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34064 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268770AbTBZO5F>;
	Wed, 26 Feb 2003 09:57:05 -0500
Message-ID: <3E5CD815.6050501@pobox.com>
Date: Wed, 26 Feb 2003 10:07:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH][ATM] remove mod_inc_use_count from lec
References: <200302261230.h1QCUox9003790@locutus.cmf.nrl.navy.mil>
In-Reply-To: <200302261230.h1QCUox9003790@locutus.cmf.nrl.navy.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> this patch removes the deprecated MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT
> from the lane client.


For patches that look ok and do not require feedback, I would suggest 
CC'ing your patches to David Miller, who is the net stack maintainer and 
seems to have been applying several of your patches so far.  Though "To: 
linux-kernel" gets your patch published, you typically want to find a 
"patch penguin" who will apply your patches and send them to 
Linus/Marcelo...

	Jeff



