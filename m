Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSHGQbP>; Wed, 7 Aug 2002 12:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHGQbP>; Wed, 7 Aug 2002 12:31:15 -0400
Received: from virtmail.zianet.com ([216.234.192.37]:13263 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S315374AbSHGQbI>;
	Wed, 7 Aug 2002 12:31:08 -0400
Message-ID: <3D514E75.4080909@zianet.com>
Date: Wed, 07 Aug 2002 10:44:37 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020802
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: Tigon3 and jumbo frames
References: <3D5045C1.6050302@zianet.com> <20020807.033820.126760020.davem@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok ok, I believe you.  There was some arp weirdness
going on between the gigi card and another eth device.
I belive I have it figured out now, sorry to bug ya.

Steve

David S. Miller wrote:

>   From: kwijibo@zianet.com
>   Date: Tue, 06 Aug 2002 15:55:13 -0600
>
>   Does the new version of the tigon 3 (tg3) drivers support jumbo
>   frames?
>
>It works, use a direct connection between two tg3 cards if you
>don't believe us :-)
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



