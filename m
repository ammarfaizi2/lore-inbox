Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290275AbSAQTyo>; Thu, 17 Jan 2002 14:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290435AbSAQTye>; Thu, 17 Jan 2002 14:54:34 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:48621 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S290275AbSAQTyX>; Thu, 17 Jan 2002 14:54:23 -0500
Message-ID: <3C472B64.6000206@wanadoo.fr>
Date: Thu, 17 Jan 2002 20:52:04 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:0.9.7) Gecko/20011221
X-Accept-Language: fr, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Tomasz Torcz <zdzichu@irc.pl>, "Michael H. Warfield" <mhw@wittsend.com>,
        Hans-Christian Armingeon <linux.johnny@gmx.net>
Subject: swapper [was OOPS on 2.4.17 ...]
In-Reply-To: <20020117182758.GA736@irc.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:
 > Process swapper (pid: 1, stackpage=c1199000)

Michael H. Warfield wrote:
 > Process swapper (pid: 0,stackpage=c022f000)

Hans-Christian Armingeon wrote:
 > Process swapper (pid: 1, stackpage=cfe8d00)

what is this swapper process involved in 2.4.17 oops ? could it be 
spawned when devfs thinks there is already a root fs mounted at boot 
time before mounting the root fs given to the boot loader ?



Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

