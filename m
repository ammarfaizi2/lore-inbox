Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293036AbSBVXHn>; Fri, 22 Feb 2002 18:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293037AbSBVXHc>; Fri, 22 Feb 2002 18:07:32 -0500
Received: from [195.63.194.11] ([195.63.194.11]:2831 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293036AbSBVXHU>;
	Fri, 22 Feb 2002 18:07:20 -0500
Message-ID: <3C76CF05.9060606@evision-ventures.com>
Date: Sat, 23 Feb 2002 00:06:45 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: G?rard Roudier <groudier@free.fr>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <20020222154011.B5783@suse.cz> <20020221211606.F1418-100000@gerard> <20020222223444.A7238@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> For some adapters, this is possible, for other it is not (at all). You
> happen to be a maintainer of one for which it is possible, and thus your
> point of view is quite different from mine - mine comes from USB and
> other parts of the device world, where no order can even be defined.
> 
> And because of that, I do not think that having the host adapters decide
> what device gets what number is a good idea. They should provide the
> information if they have it, but the final decision should definitely be
> done in userspace, by the hotplug agent.
> 
> Ie. it should be configurable.

Partition labeling takes care of about 99% + 1% of
the ordering problems for disk drives.


