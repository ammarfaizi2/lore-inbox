Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281999AbRKZSTC>; Mon, 26 Nov 2001 13:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281997AbRKZSSO>; Mon, 26 Nov 2001 13:18:14 -0500
Received: from james.kalifornia.com ([208.179.59.2]:61246 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S281998AbRKZSQ0>; Mon, 26 Nov 2001 13:16:26 -0500
Message-ID: <3C0286DE.50805@blue-labs.org>
Date: Mon, 26 Nov 2001 13:15:58 -0500
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011125
X-Accept-Language: en-us
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
In-Reply-To: <Pine.LNX.3.96.1011126114550.26538A-100000@gatekeeper.tmr.com> <87elmlmn81.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modular or monolithic, the bogus messages are the same.

>Yes. You can't use the module before you mounted the root filesystem.
>This is a reason for not seeing an error message.
>


