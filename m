Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269186AbRIHTjF>; Sat, 8 Sep 2001 15:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269221AbRIHTiz>; Sat, 8 Sep 2001 15:38:55 -0400
Received: from unused ([12.150.234.220]:9469 "EHLO one.isilinux.com")
	by vger.kernel.org with ESMTP id <S269186AbRIHTiq>;
	Sat, 8 Sep 2001 15:38:46 -0400
Message-ID: <3B9A73D5.9020607@interactivesi.com>
Date: Sat, 08 Sep 2001 14:39:01 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: kernel hangs in 118th call to vmalloc
In-Reply-To: <3B8FDA36.5010206@interactivesi.com> <m1ae05h6we.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> What is wrong with using SPD to detect interesting properties of
> memory chips?  That should be safer and usually easier then what you
> are trying now. 

Our hardware does not interface with SPD.  So I can't use SPD to query the 
properties.  Besides, it wouldn't change anything if I did.  I still need to 
clear out RAM.


