Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSDAIRQ>; Mon, 1 Apr 2002 03:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSDAIRH>; Mon, 1 Apr 2002 03:17:07 -0500
Received: from ip143.gte1.rb1.bel.nwlink.com ([209.20.131.143]:33716 "EHLO
	khem.blackfedora.com") by vger.kernel.org with ESMTP
	id <S310654AbSDAIQv>; Mon, 1 Apr 2002 03:16:51 -0500
To: Dumitru Ciobarcianu <cioby@lnx.ro>
Cc: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: Number of loopback devices
In-Reply-To: <20020401003015.GO4583@vnl.com>
	<1017647543.1449.1.camel@LNX.iNES.RO>
From: Mark Atwood <mra@pobox.com>
Date: 01 Apr 2002 00:17:06 -0800
Message-ID: <m3u1qvj0jh.fsf@khem.blackfedora.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dumitru Ciobarcianu <cioby@lnx.ro> writes:
> It is configurable.
> 
> options loop max_loop=n
> 
> in modules.conf, or if youre using it builtin

Does it take lots of kernal memory to set it high? Or how hard would
it be to make it eventually completely dynamic?

-- 
Mark Atwood   | Well done is better than well said.
mra@pobox.com | 
http://www.pobox.com/~mra
