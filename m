Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSEQH76>; Fri, 17 May 2002 03:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSEQH75>; Fri, 17 May 2002 03:59:57 -0400
Received: from mailer.zib.de ([130.73.108.11]:26024 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S315457AbSEQH7z>;
	Fri, 17 May 2002 03:59:55 -0400
Subject: Re: PPPoE for sparc
From: Sebastian Heidl <heidl@zib.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020516.181331.44763514.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 17 May 2002 09:59:49 +0200
Message-Id: <1021622390.4280.3.camel@csr-pc6>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fre, 2002-05-17 um 03.13 schrieb David S. Miller:
>    From: Sebastian Heidl <heidl@zib.de>
>    Date: 16 May 2002 16:03:45 +0200
>    
>    Is there a particular reason why the PPPoE driver is not
>    offered when I do something like "make ARCH=sparc menuconfig" ?
>    Sure it's not listed in config.in for sparc (2.4.19-pre7) but
>    why ?
>    
> Nobody got around to adding it, if you send me a patch
> that adds it I'll put it into my tree and forward it on
> to Marcelo/Linus.

never mind, pre8 includes it.
thanks,
_sh_

