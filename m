Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274995AbRJAMQG>; Mon, 1 Oct 2001 08:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274994AbRJAMPq>; Mon, 1 Oct 2001 08:15:46 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:56723 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S274896AbRJAMPn>; Mon, 1 Oct 2001 08:15:43 -0400
Message-ID: <3BB85D50.7020401@antefacto.com>
Date: Mon, 01 Oct 2001 13:10:56 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
CC: linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.GSO.4.21.0109251332470.24321-100000@weyl.math.psu.edu> <tgr8srrycp.fsf@mercury.rus.uni-stuttgart.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer wrote:

>Alexander Viro <viro@math.psu.edu> writes:
>
>>On Tue, 25 Sep 2001, William Scott Lockwood III wrote:
>>
>>>dmask?
>>>
>>Umm... That makes sense.
>>
>
>I wrote a small patch for that over a year ago, but it wasn't
>integrated because it didn't seem necessary because of the noexec
>option, and we didn't know about about the mc problem back then.
>
It's not just mc. ls coloring, shell tab completion, ...

Padraig.

