Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265035AbRFURC3>; Thu, 21 Jun 2001 13:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265036AbRFURCT>; Thu, 21 Jun 2001 13:02:19 -0400
Received: from mail.efore.fi ([62.236.103.42]:7954 "EHLO maxwell.efore.fi")
	by vger.kernel.org with ESMTP id <S265035AbRFURCJ>;
	Thu, 21 Jun 2001 13:02:09 -0400
Message-ID: <3B32280A.ADC08780@efore.fi>
Date: Thu, 21 Jun 2001 19:59:54 +0300
From: Lauri Tischler <lauri.tischler@efore.fi>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard J Moore <richardj_moore@uk.ibm.com>
CC: Jonathan Morton <chromi@cyberspace.org>,
        Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
In-Reply-To: <OFE74ECCAE.A9CB9437-ON80256A72.0045BC45@portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard J Moore wrote:
> 
> > 59.42886726469 ±2°C is obviously ludicrous, even if that's
> > what my calculator gives me.  I should instead write 59 ±2°C, since
> 
> So, if I follow you argument then shouldn't you be writing 58 ±2°C or
> should it be 60 ±2°C ?

What it means is that whatever dingus measured the temperature, reported
the temperature as 59C.  Also it is known that the accuracy of said dingus
is +-2C, so the real temperature can be anywhere between 57C and 61C.
That assuming that the dingus is calibrated.

-- 
lauri.tischler@iki.fi * Man created god as His image *
                      *  Man has horrid imagination  *

