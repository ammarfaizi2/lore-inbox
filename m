Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270147AbRHGImP>; Tue, 7 Aug 2001 04:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270148AbRHGImG>; Tue, 7 Aug 2001 04:42:06 -0400
Received: from james.kalifornia.com ([208.179.59.2]:37488 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S270147AbRHGIlr>; Tue, 7 Aug 2001 04:41:47 -0400
Message-ID: <3B6FA932.1020608@kalifornia.com>
Date: Tue, 07 Aug 2001 01:39:14 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <200108070624.f776Ofl21096@www.2ka.mipt.ru> <Pine.LNX.4.33.0108062338130.5491-100000@mackman.net> <200108070705.f7775xl27094@www.2ka.mipt.ru> <20010807082324.C9202@dev.sportingbet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter wrote:

>You don't.  Swap is only good for one power-cycle anyway, regardless of
>encryption.  As such, the legitimate user won't ever need to regenerate the
>key.  Since black hat can't root, they can't get the key (assuming physical
>security is OK), and after reboot they can't recover the contents of the swap
>space because it is encrypted.  So even if they nick the machine/drive/whatever
>they can't get the swap contents after the power has been cycled and the key
>lost.
>

Until someone figures out how to dump the key to disk.

-- 
Please note - If you do not have the same beliefs as we do, you are
going to burn in Hell forever.



