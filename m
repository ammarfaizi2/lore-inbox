Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSFFXp5>; Thu, 6 Jun 2002 19:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSFFXp4>; Thu, 6 Jun 2002 19:45:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34189 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313113AbSFFXp4>;
	Thu, 6 Jun 2002 19:45:56 -0400
Date: Thu, 06 Jun 2002 16:45:13 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: Panic from 2.4.19-pre9-aa2
Message-ID: <103110000.1023407113@flay>
In-Reply-To: <20020606231521.GB1004@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At first glance this seems a miscompilation, a compiler bug, not bug in
> 2.4.19pre9aa2 (this clearly explains why you're the only one reproducing
> this weird oops). it even sounds like ksymoops is buggy, ksymoops had to
> say c0147dad (+7d), not c0147dac and +7c (maybe you compiled ksymoops
> with the same compiler of the kernel? If not Keith should have a look
> here).
>
> What compiler are you using? Maybe 2.96?

Errm ....  Redhat 6.2 default ... egcs-2.91.66 .... time to upgrade ?? ;-) ;-)
Pah ... reinstalling these machines is a pain in the ass .... ;-)

M.

