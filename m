Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287705AbSANQsM>; Mon, 14 Jan 2002 11:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287699AbSANQqI>; Mon, 14 Jan 2002 11:46:08 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:28082 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S287615AbSANQpR>;
	Mon, 14 Jan 2002 11:45:17 -0500
Message-ID: <3C4309EC.3090805@candelatech.com>
Date: Mon, 14 Jan 2002 09:40:12 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: Multi-packet read/write for packet sockets?
In-Reply-To: <3C430323.6060707@candelatech.com> <20020114.082621.105170691.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excellent...  Does anyone have a snippet of code that
shows how this works?

David S. Miller wrote:

> Use mmap() on packet sockets... it is even faster than the
> thing which you propose.
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


