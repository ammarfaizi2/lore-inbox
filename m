Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSD3KDk>; Tue, 30 Apr 2002 06:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSD3KDj>; Tue, 30 Apr 2002 06:03:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15880 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313189AbSD3KDi>; Tue, 30 Apr 2002 06:03:38 -0400
Message-ID: <3CCE5D3B.40207@evision-ventures.com>
Date: Tue, 30 Apr 2002 11:00:43 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Hanna V Linder <hannal@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] Re: 2.5.11 breakage
In-Reply-To: <Pine.GSO.4.21.0204291806280.5397-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW.> Is anyone of you looking at the folding of
the contents of blk_dev[major] (custom request queue information)
in to struct block_device from fs.h, where it naturally belongs?

