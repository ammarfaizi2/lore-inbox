Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262444AbSJQXH0>; Thu, 17 Oct 2002 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSJQXGX>; Thu, 17 Oct 2002 19:06:23 -0400
Received: from hermes.domdv.de ([193.102.202.1]:33287 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S262422AbSJQXFz>;
	Thu, 17 Oct 2002 19:05:55 -0400
Message-ID: <3DAF4382.9020800@domdv.de>
Date: Fri, 18 Oct 2002 01:10:58 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jgarzik@pobox.com, greg@kroah.com, hch@infradead.org,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
References: <20021017.131830.27803403.davem@redhat.com>	<3DAF3EF1.50500@domdv.de>	<3DAF412A.7060702@pobox.com> <20021017.155630.98395232.davem@redhat.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I'm now leaning more towards something like what Al Viro
> hinted at earlier, creating generic per-file/fd attributes.
> This kind of stuff.
> 
I'm perfectly happy with anything that doesn't kill LSM.
-- 
Andreas Steinmetz

