Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVISFJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVISFJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVISFJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:09:09 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:35505 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932260AbVISFJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:09:08 -0400
Message-ID: <432E47F4.202@namesys.com>
Date: Sun, 18 Sep 2005 22:09:08 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com> <20050916174028.GA32745@infradead.org> <432B1F84.3000902@namesys.com> <20050916205045.GI28578@csclub.uwaterloo.ca> <20050916205323.GJ28578@csclub.uwaterloo.ca>
In-Reply-To: <20050916205323.GJ28578@csclub.uwaterloo.ca>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:

>
> Neither was ready for use when they were
>included in the kernel and should probably have had big warning signs in
>the kernel config for them. 
>  
>
They did have warning signs: they were labeled experimental....  as is
reiser4. 

At some point developers and their limited size mailing list simply
cannot make things crash, and then it needs to go in to the main kernel
labeled experimental.

Of course, the reiser4 code is not as stable as it was before the
changes Christoph asked for.

Hans
