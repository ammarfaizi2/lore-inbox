Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132231AbRCVXI7>; Thu, 22 Mar 2001 18:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132238AbRCVXIu>; Thu, 22 Mar 2001 18:08:50 -0500
Received: from ccs.covici.com ([209.249.181.196]:9988 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S132231AbRCVXIl>;
	Thu, 22 Mar 2001 18:08:41 -0500
To: linux-kernel@vger.kernel.org
Subject: serial driver question
From: John Covici <covici@ccs.covici.com>
Date: 22 Mar 2001 18:07:52 -0500
Message-ID: <m3ae6dpflj.fsf@ccs.covici.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been wondering about the serial drivers shared irq
configuration parameter.  Will it allow two dumb serial ports which
know nothing about sharing irq's to actually share the same irq, or
does the actual hardware have to support some kind of irq sharing for
this to work?

I did try two ports on the same irq, but one of them isn't seem at all
by Linux, so I am quite curious whether I am barking up the wrong
line?

Thanks.


-- 
         John Covici
         covici@ccs.covici.com
