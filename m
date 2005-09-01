Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030535AbVIAXhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbVIAXhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030538AbVIAXhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:37:07 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:50107 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030533AbVIAXhE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:37:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qKyRjMlDD7aKFZVIQBAMTQl2CoxT7bzL4x7lskSANGHIp0JfMavBCvVCJJrKR4gPJQnRIFtFkul3zAZRGWAMf/zoasQK56zlPeifczmsjgCh5+VAE7d+tq8enUEAigmsnsTp80/tnTZKYpTCE/ADQvgvRR/u31ITWWt0QOwxH7o=
Message-ID: <9a87484905090116376866f80a@mail.gmail.com>
Date: Fri, 2 Sep 2005 01:37:02 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Ion Badulescu <lists@limebrokerage.com>
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x kernels
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com>
	 <20050901.154300.118239765.davem@davemloft.net>
	 <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/05, Ion Badulescu <lists@limebrokerage.com> wrote:
> Hi David,
> 
> On Thu, 1 Sep 2005, David S. Miller wrote:
> 
> > Thanks for the empty posting.  Please provide the content you
> > intended to post, and furthermore please post it to the network
> > developer mailing list, netdev@vger.kernel.org
> 
> First of all, thanks for the reply (even to an empty posting :).
> 
> The posting wasn't actually empty, it was probably too long (94K according

Two solutions commonly applied to that problem :

 - put the big file(s) online somewhere and include an URL in the email
 - compress the file(s) and attach the compressed files to the email

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
