Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287945AbSAQA0N>; Wed, 16 Jan 2002 19:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286462AbSAQA0D>; Wed, 16 Jan 2002 19:26:03 -0500
Received: from freeside.toyota.com ([63.87.74.7]:57617 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S286411AbSAQAZy>; Wed, 16 Jan 2002 19:25:54 -0500
Message-ID: <3C461A09.8060900@lexus.com>
Date: Wed, 16 Jan 2002 16:25:45 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020114
X-Accept-Language: en-us
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Rik spreading bullshit about VM
In-Reply-To: <20020116200459.E835@athlon.random> <20020117000758.GL10175@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:

>Sorry, but in my opinion Rik's rmap VM still beats your VM under IO
>load. My benchmark is very simple: import a kernel tree into a CVS tree
>that already contains about 470 other kernel trees. Both the import
>directory and the CVS root are on the same disk. With 2.4.17 the mp3
>player stutters, I can't even read email or edit a couple of files with
>XEmacs at the same time. With 2.4.17-rmap-11a the mp3 player runs
>smoothly and email and XEmacs are usable again.
>
Nice try, but do the test again with 2.4.18-pre2-aa2 -

2.4.17 doesn't neccesarily have all andrea's fixes.

Just my .02

jjs

