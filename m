Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSIJQ1m>; Tue, 10 Sep 2002 12:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317642AbSIJQ1m>; Tue, 10 Sep 2002 12:27:42 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:52209 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S317637AbSIJQ1m>; Tue, 10 Sep 2002 12:27:42 -0400
Date: Tue, 10 Sep 2002 09:32:34 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <3D7E1EA2.3080506@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <Pine.LNX.4.44.0209091926320.1911-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In short:
>  
>   Either you want debugging (in which case BUG() is the wrong thing to
>   do), or you don't want debugging (in which case BUG() is the wrong thing
>   to do). You can choose either, but in neither case is BUG() acceptable.

Or in even shorter sound bite format:  "Just say no to BUG()s."

:)



