Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTESKIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTESKIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:08:45 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:15626 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262275AbTESKIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:08:43 -0400
Message-ID: <3EC8AFE1.6090409@aitel.hist.no>
Date: Mon, 19 May 2003 12:20:17 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Neale Banks <neale@lowendale.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: What exactly does "supports Linux" mean?
References: <Pine.LNX.4.05.10305190807510.12028-100000@marina.lowendale.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neale Banks wrote:
> On Sun, 18 May 2003, Pavel Machek wrote:

>>[Really, if the card is common enough, and driver sources are
>>available, they are going to be in kernel.org kernel within few weeks.]
> 
> Iff:
> (1) the sources etc constitute "sufficient" documentation (e.g. poke magic
> value into magic register might not help enough :-( ).

Sure.

> (2) the sources are not only "included" but are "freely" modifiable and
> redistributable.

No need.  As long as there is no NDA, which there isn't when
you get a cd bundled with the thing.  Restricted source then
mean that you can't edit it so it fits your kernel and
redistribute.  But you can read it and see how the thing works,
if (1) is satisfied.  Then you use your knowledge and write
a driver from scratch.  More work, but legal.

Of course a completely free driver is even better. :-)

Helge Hafting

