Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130239AbQKXXA1>; Fri, 24 Nov 2000 18:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130255AbQKXXAR>; Fri, 24 Nov 2000 18:00:17 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:57613 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S130239AbQKXXAF>; Fri, 24 Nov 2000 18:00:05 -0500
Date: Fri, 24 Nov 2000 17:30:03 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: "J. Dow" <jdow@earthlink.net>
cc: <FyreMoon@fyremoon.net>, <coredumping@hotmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: About IP address
In-Reply-To: <07bf01c05664$15462210$0a25a8c0@wizardess.wiz>
Message-ID: <Pine.LNX.4.30.0011241729270.5879-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, J. Dow wrote:

>Date: Fri, 24 Nov 2000 14:15:41 -0800
>From: J. Dow <jdow@earthlink.net>
>To: FyreMoon@fyremoon.net, coredumping@hotmail.com
>Cc: linux-kernel@vger.kernel.org
>Content-Type: text/plain;
>        charset="iso-8859-1"
>Subject: Re: About IP address
>
>From: "John Crowhurst" <FyreMoon@fyremoon.net>
>
>> > For example, Class B address range is 128.1.0.0 ~ 191.254.0.0
>> >
>> > Why 128.0.0.0 and 191.255.0.0 can't use ?
>> >
>> > I can't understand it
>>
>> This is because its the network and broadcast addresses of a Class A address
>> range. Simple answer :)
>
>That is not a responsive answer, John. And since you gave it I issue you the
>challenge to declare why 128.0.0.1 through 191.255.255.254 are not legal
>address ranges.

One possibility: rfc1700

;o)


----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

Looking for Linux software?   http://freshmeat.net  http://www.rpmfind.net
http://filewatcher.org  http://www.coldstorage.org  http://sourceforge.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
