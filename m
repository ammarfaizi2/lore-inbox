Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbTIXX6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 19:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTIXX6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 19:58:32 -0400
Received: from [212.97.163.22] ([212.97.163.22]:171 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261582AbTIXX6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 19:58:31 -0400
Date: Thu, 25 Sep 2003 01:58:19 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: POP3 checker [was Re: ATTACK TO MY SYSTEM]
Message-ID: <20030924235819.GA3892@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.23, Mike Galbraith wrote:
> At 03:40 PM 9/23/2003 +0200, you wrote:
> 
> >Some pointer to that pop previewer ?
> 
> I'm using freeware from webattack.com (this box is XP).  If you find 
> something for linux, please drop me a line.
> 

I know this had got very off-topic, but as so many people had this problem...
Finally I found something. Look at 'popchecker':

http://www.ludd.luth.se/~staham/linux/programs.html
 
It works very nicely.
I think is would be easy to tweak it to automagically delete messages
bigger than a given size. Perhaps when I have some spare time...
or I found something that already does this.
Even with popchecker and some grep+sort+sed etc...

This can become a mandatory applet nowadays.
Hope this helps ;).

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre5-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
