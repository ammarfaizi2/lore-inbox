Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVAYPy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVAYPy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVAYPy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:54:56 -0500
Received: from [195.23.16.24] ([195.23.16.24]:64939 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261990AbVAYPyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:54:25 -0500
Message-ID: <41F66B61.6040101@grupopie.com>
Date: Tue, 25 Jan 2005 15:53:05 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>, alexn@dsv.su.se,
       kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       lennert.vanalboom@ugent.be
Subject: OT Re: Memory leak in 2.6.11-rc1?
References: <20050121161959.GO3922@fi.muni.cz> <1106360639.15804.1.camel@boxen> <20050123091154.GC16648@suse.de> <20050123011918.295db8e8.akpm@osdl.org> <20050123095608.GD16648@suse.de> <20050123023248.263daca9.akpm@osdl.org> <1106528219.867.22.camel@boxen> <20050124204659.GB19242@suse.de> <20050124125649.35f3dafd.akpm@osdl.org> <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 24 Jan 2005, Andrew Morton wrote:
> 
>>Would indicate that the new pipe code is leaking.
> 
> 
> Duh. It's the pipe merging.

Have we just seen the "plumber" side of Linus?

After all, he just fixed a "leaking pipe" :)


(sorry for the OT, just couldn't help it)

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu
