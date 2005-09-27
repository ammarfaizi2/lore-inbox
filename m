Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVI0MKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVI0MKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVI0MKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:10:11 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:20719 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1750703AbVI0MKK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:10:10 -0400
In-Reply-To: <01984F80-801E-4098-88B5-65A7AD7D1CAD@ime.usp.br>
References: <20050927111038.GA22172@ime.usp.br> <20050927133447.c3caeb25.diegocg@gmail.com> <01984F80-801E-4098-88B5-65A7AD7D1CAD@ime.usp.br>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <A6BC4B10-EB89-4F7F-A92C-E8D3B828933F@ime.usp.br>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Date: Tue, 27 Sep 2005 09:10:05 -0300
To: Diego Calleja <diegocg@gmail.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops! I forgot to answer your question completely.

On Sep 27, 2005, at 8:58 AM, Rogério Brito wrote:
> On Sep 27, 2005, at 8:34 AM, Diego Calleja wrote:
>> You don't say what filesystem are you using. Have you tried  
>> running fsck?
>
> Oh, sure. I forgot to mention that. I am using ext3 with ACL/xattrs  
> and with hashed B-Trees (I optimized the filesystem with option -D  
> of fsck.ext2). Would one of these things be a possible cause for  
> the strange behaviour that I am seeing?

Yes, I did run fsck. Twice now, in a row (shutdown -r -F now).  
Nothing was found, unfortunately. :-( I'm really running out of  
ideas. :-(


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/


