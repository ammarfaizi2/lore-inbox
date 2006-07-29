Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWG3GCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWG3GCJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 02:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWG3GCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 02:02:09 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:55258 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751139AbWG3GCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 02:02:08 -0400
Message-ID: <44CBE8D7.7010008@namesys.com>
Date: Sat, 29 Jul 2006 17:01:43 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Nikita Danilov <nikita@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>	<44CA31D2.70203@slaphack.com>	<Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>	<44C9FB93.9040201@namesys.com>	<44CA6905.4050002@slaphack.com>	<44CA126C.7050403@namesys.com>	<44CA8771.1040708@slaphack.com>	<44CABB87.3050509@namesys.com> <17611.21640.208153.492074@gargle.gargle.HOWL> <44CBA99F.2040306@slaphack.com>
In-Reply-To: <44CBA99F.2040306@slaphack.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>Nikita Danilov wrote:
>
>  
>
>>As you see, ext2 code already has multiple file "plugins", with
>>persistent "plugin id" (stored in i_mode field of on-disk struct
>>ext2_inode).
>>    
>>
>
>Aha!  So here's another question:  Is it fair to ask Reiser4 to make its
>plugins generic, or should we be asking ext2/3 first?
>
>  
>
Shhhhh.....,  ext* already made their plugins generic, job is done....:) 
