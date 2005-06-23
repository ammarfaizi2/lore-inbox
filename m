Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVFWVVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVFWVVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVFWVSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:18:03 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:13087 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262700AbVFWVQF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:16:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Acz49pSuA10ZwqVyQcKqBRoxADRcGQfSmw9v3iirGzK3qCv+PffZ0dn9eaUe/R4HMgvnqiHwn3xslnFsnp72KgWPNIXUrqiCN1SxTeZeXAkolFsVYJXnl5ORn4P/DfwvnpBMwHkz89L1mwY7iDRr6UDdcXJ3PQ6bOCOsII08AyE=
Message-ID: <9a87484905062314165a4a3ecb@mail.gmail.com>
Date: Thu, 23 Jun 2005 23:16:04 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] SLIP: simplify sl_free_bufs
Cc: juhl-lkml@dif.dk, loz@holmes.demon.co.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050623.141038.122619255.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0506152136310.3842@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.62.0506232243340.7467@dragon.hyggekrogen.localhost>
	 <20050623.141038.122619255.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/05, David S. Miller <davem@davemloft.net> wrote:
> From: Jesper Juhl <juhl-lkml@dif.dk>
> Date: Thu, 23 Jun 2005 22:46:06 +0200 (CEST)
> 
> > The patch below still applies cleanly to 2.6.12 - any chance this might
> > get applied? or any good reasons not to apply it?
> 
> I'll put it in my tree, 

Thanks.

>give me a day or so.
> 
No problem. :)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
