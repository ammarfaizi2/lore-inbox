Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292956AbSCMKLh>; Wed, 13 Mar 2002 05:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSCMKL2>; Wed, 13 Mar 2002 05:11:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58632 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292956AbSCMKLS>;
	Wed, 13 Mar 2002 05:11:18 -0500
Message-ID: <3C8F25BE.9040000@mandrakesoft.com>
Date: Wed, 13 Mar 2002 05:11:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ide filters / 'ide dump' / 'bio dump'
In-Reply-To: <E16kcTV-0002ar-00@the-village.bc.nu> <3C8D6CA4.8060604@mandrakesoft.com> <20020313091422.A23422@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

># biodump /dev/hda
>09:09:33.023 READ block 12345 [10 blocks]
>09:09:33.024 READ block 12355 [10 blocks]
>09:09:33.025 READ block 12365 [10 blocks]
>09:09:34.000 WRITE block 12345 [1 block]
>


Definitely an interesting idea...   With this new stuff Linus talked 
about in his proposal and what I'm thinking about, it shouldn't be too 
hard to do.

    Jeff




