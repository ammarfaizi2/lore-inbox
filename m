Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbVIAWqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbVIAWqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbVIAWqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:46:08 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:63946 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030491AbVIAWqG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:46:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fNdUCEISc+Wq06u6tpGmRfrdpjKL5veep+DhXrEn0owVQOdbmzI8qh9b06mxQSoSQy6tU8QZwOHT/iYas9X56lFqo2KLWPDL14kpDuN5S5plEEv3ACF5XX8dP0e43McIqzVVEuflLpFh1PmDjtvFO94NM+bC2J4qScbqR2cq7e0=
Message-ID: <9a874849050901154544e8417d@mail.gmail.com>
Date: Fri, 2 Sep 2005 00:45:59 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto_free_tfm callers no longer need to check for NULL
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
       sri@us.ibm.com, bfields@fieldses.org, yoshfuji@linux-ipv6.org,
       breed@users.sourceforge.net, andros@citi.umich.edu, adobriyan@mail.ru
In-Reply-To: <20050901.153142.18055974.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508312220.14929.jesper.juhl@gmail.com>
	 <20050901.153142.18055974.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/05, David S. Miller <davem@davemloft.net> wrote:
> 
> Applied, thanks Jesper.
> 
> Can you avoid those "/./" things from showing up in the file paths of
> the patches you post?  They upset the GIT patch application scripts
> and diff verifiers, so I had to edit them out by hand.
> 
No problem, I actually saw those (an unfortunate biproduct of a script
I used to diff the individual files) and told myself that I should
remember to remove them before sending the final patch, but obviously
I forgot.

> Thanks again.
> 
You are most welcome.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
