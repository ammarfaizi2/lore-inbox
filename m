Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291551AbSBMLBn>; Wed, 13 Feb 2002 06:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291553AbSBMLBd>; Wed, 13 Feb 2002 06:01:33 -0500
Received: from [195.63.194.11] ([195.63.194.11]:28166 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291551AbSBMLBY>; Wed, 13 Feb 2002 06:01:24 -0500
Message-ID: <3C6A4770.2030709@evision-ventures.com>
Date: Wed, 13 Feb 2002 12:01:04 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andre Hedrick <andre@linuxdiskcert.org>, Vojtech Pavlik <vojtech@suse.cz>,
        Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020213074214.S1907@suse.de> <Pine.LNX.4.10.10202122327570.668-100000@master.linux-ide.org> <20020213084756.T1907@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>The global read-ahead change is surely not what we want. The IDE
>cleanups I've seen so far look good to me.
>

Ask Alan Cox - even he saw finally that it's just removal of dead code...




