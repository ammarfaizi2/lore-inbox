Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbRCAFcF>; Thu, 1 Mar 2001 00:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129531AbRCAFb4>; Thu, 1 Mar 2001 00:31:56 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:17412 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S129529AbRCAFbq>;
	Thu, 1 Mar 2001 00:31:46 -0500
Message-ID: <3A9DDEC1.B2C24C58@sh0n.net>
Date: Thu, 01 Mar 2001 00:31:45 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net - http://www.sh0n.net/spstarr
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Sethman <androsyn@ratbox.org>, lkm <linux-kernel@vger.kernel.org>
Subject: Re: Odd error message..
In-Reply-To: <Pine.LNX.4.21.0103010025500.27615-100000@squeaker.ratbox.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hehe, your not the only one getting that :)

I get it from the sg.o module. (it appears).

Aaron Sethman wrote:

> __alloc_pages: 2-order allocation failed.
>
> I get many of these across the console when testing a network application
> that. Basically the client opens up a bunch of connections to the server
> and starts firing off data as quickly as it can.  If you need further
> information please let me know.
>
> Regards,
>
> Aaron
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Hugged a Tux today? (tm)



