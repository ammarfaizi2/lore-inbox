Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbQKPPRK>; Thu, 16 Nov 2000 10:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130681AbQKPPRB>; Thu, 16 Nov 2000 10:17:01 -0500
Received: from scaup.prod.itd.earthlink.net ([207.217.121.49]:55995 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130643AbQKPPQo>; Thu, 16 Nov 2000 10:16:44 -0500
To: "Sergey Volkoff" <sve@raiden.bancorp.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: none
In-Reply-To: <001a01c04fb4$88ee4c80$6e07a8c0@ru>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 16 Nov 2000 06:46:06 -0800
In-Reply-To: <001a01c04fb4$88ee4c80$6e07a8c0@ru>
Message-ID: <m3zoj0kma9.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey Volkoff" <sve@raiden.bancorp.ru> writes:

> I installed the latest kernel ( 2.4.0-test11-pre5 ). On boot with new kernel, system hangup before booting is completed.
> 
> I don't know where, but I think this occurs when system is attempt to mount filesystems.

do you have devfsd installed if you have compiled in ? it's included
with your mdk7.2

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
