Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSG2K0Y>; Mon, 29 Jul 2002 06:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSG2K0Y>; Mon, 29 Jul 2002 06:26:24 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17934 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314446AbSG2K0Y>; Mon, 29 Jul 2002 06:26:24 -0400
Message-ID: <3D4517EA.5030305@evision.ag>
Date: Mon, 29 Jul 2002 12:24:42 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: martin@dalecki.de, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com> <3D40E62B.9070202@evision.ag> <20020726143840.GC8761@suse.de> <3D416625.4050205@evision.ag> <20020728212523.A3460@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> 
> But the crap still got merged, sigh... Yet again an excellent point of
> why stuff like this should go through the maintainer. Apparently Linus
> blindly applies this stuff.

Jens. Please note that this doesn't make *anything* worser then before,
since I don't use this function right now.

