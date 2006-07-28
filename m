Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161291AbWG1UlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbWG1UlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWG1UlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:41:15 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:59565 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1161291AbWG1UlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:41:15 -0400
Message-ID: <44CA13E3.4060208@namesys.com>
Date: Fri, 28 Jul 2006 07:40:51 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hua Zhong <hzhong@gmail.com>
CC: "'David Masover'" <ninja@slaphack.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Horst H. von Brand'" <vonbrand@inf.utfsm.cl>,
       "'Jeff Garzik'" <jeff@garzik.org>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Theodore Tso'" <tytso@mit.edu>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'ReiserFS List'" <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <005e01c6b282$7eb372e0$493d010a@nuitysystems.com>
In-Reply-To: <005e01c6b282$7eb372e0$493d010a@nuitysystems.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:

>I remember someone said something along the lines of "Linux is evolution, not revolution". To me it seems unreasonable to put all
>the "revolutionary" VFS burden upon reiserfs team. It's not practical.
>
>  
>
>
Thanks for saying that Hua.  We have a guy named Nate Diller, who
probably could fix VFS up pretty nicely if Namesys did not have him
earning the consulting income the rest of the team lives on (he is doing
io scheduler work at the moment).   That said, he would need a lot of
time, and stopping reiser4 inclusion to await his work merely ensures
his work will never happen.
