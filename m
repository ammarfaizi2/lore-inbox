Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTJZMFM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 07:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTJZMFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 07:05:12 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:40081 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263014AbTJZMFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 07:05:06 -0500
Message-ID: <3F9BB870.1010500@namesys.com>
Date: Sun, 26 Oct 2003 15:05:04 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
CC: ndiamond@wta.att.ne.jp, vitaly@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results end
References: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60> <3F9BA98B.20408@namesys.com> <200310261259.h9QCxhWv004314@car.linuxhacker.ru>
In-Reply-To: <200310261259.h9QCxhWv004314@car.linuxhacker.ru>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>
>HR> Badblocks support is in reiser4, and anyone is welcome to update the 
>HR> patch for V3, or sponsor us to do it.  We are very low on cash, so we 
>
>Actually that v3 patch does not do bad blocks remapping in case of
>write failure, it only does remapping when you manually ask it.
>And biggest part of badblocks support in reiser3 is in reiserfsck and tools
>(and in not that bad shape, last time I looked).
>As for remapping bad blocks on write failure, the only PC OS that was doing
>this that comes to my mind is Novell Netware (I think they called it a "hotfix"
>or something like that).
>
>Bye,
>    Oleg
>
>
>  
>
I wasn't saying we would do what is in Netware, and as far as being in 
bad shape is concerned, from the user's point of view it either works or 
it doesn't.

-- 
Hans


