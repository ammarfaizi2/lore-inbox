Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313346AbSDOXF0>; Mon, 15 Apr 2002 19:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313355AbSDOXFZ>; Mon, 15 Apr 2002 19:05:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1294 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313346AbSDOXFY>; Mon, 15 Apr 2002 19:05:24 -0400
Message-ID: <3CBB5C9F.6020001@zytor.com>
Date: Mon, 15 Apr 2002 16:05:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: link() security
In-Reply-To: <E16xFGx-0007As-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>Not to mention the fact that the single file mailbox design is itself
>>flawed.  Mailboxes are fundamentally directories, which news server
>>authors quickly realized.
>
> And then unrealized when they hit performance limitations. Its a trade off
> and one that most news systems seem to prefer to use a custom database
> for

Well, a database is basically a custom filesystem.

	-hpa

