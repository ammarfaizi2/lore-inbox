Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTJTH02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTJTHYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:24:14 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:40639 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262419AbTJTHWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:22:44 -0400
Message-ID: <3F938D42.7060508@namesys.com>
Date: Mon, 20 Oct 2003 11:22:42 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Larry McVoy <lm@bitmover.com>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Justin Cormack <justin@street-vision.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vitaly Fertman <vitaly@namesys.com>, Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60> <20031019041553.GA25372@work.bitmover.com> <3F924660.4040405@namesys.com> <20031019194933.GB354@elf.ucw.cz>
In-Reply-To: <20031019194933.GB354@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>
>Even better, use crc loop method, and do checks at block device
>level. I had patch to implement that...
>								Pavel
>  
>
this would not get the memory errors that Larry was talking about as 
well..... which is not to discount your patch, sounds like a reasonable 
patch.....

-- 
Hans


