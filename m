Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136490AbREDTtY>; Fri, 4 May 2001 15:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136491AbREDTtF>; Fri, 4 May 2001 15:49:05 -0400
Received: from [64.64.109.142] ([64.64.109.142]:35082 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S136490AbREDTsu>; Fri, 4 May 2001 15:48:50 -0400
Message-ID: <3AF30781.B98EF7AF@didntduck.org>
Date: Fri, 04 May 2001 15:48:17 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Seth Goldberg <bergsoft@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
In-Reply-To: <3AF2E569.47AED98D@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth Goldberg wrote:
> 
> Hi,
> 
>  After removing my head from my a**, I revised the code that checks
> the memory copy in the fast_page_copy routine.  The machine then
> proceeded
> not to stop at my panic, but I got my "normal" oopses.  I then had an
> idea and removed all the prefetch instructions from the beginning of the
> routine and tried the resultin kernel.  I now have no crashes.
> What could this mean?

What are your "normal" oopses?

--

				Brian Gerst
