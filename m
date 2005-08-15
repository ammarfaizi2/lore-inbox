Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVHOLPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVHOLPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 07:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbVHOLPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 07:15:25 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:59444 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932570AbVHOLPY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 07:15:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GKZD2nCW1woqUE4hIR172ZucAi8w/WTe3rxE9oFKU6qjE6rRM8oAyypVaxllUxfwshOIly6oypGj42YGN48X3It6+iEzQkD0Ex+s34mtTZ0j5zfHBZV35HLLdv/YbJCCnv7L6Cs7j7qpaftxAgw4X1edIvyqNH1Y6QYVnsDc5wg=
Message-ID: <2cd57c900508150415753af3d8@mail.gmail.com>
Date: Mon, 15 Aug 2005 19:15:19 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Re: oops in kernel 2.6.11.10
Cc: frank nero <m4rcos2003@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050815103252.GA15843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050530021313.43231.qmail@web32601.mail.mud.yahoo.com>
	 <2cd57c900508150019544d49ca@mail.gmail.com>
	 <20050815103252.GA15843@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> Question, is there a relation with my bug ? See the mail with Oops and
> USBStorage ?

No.

> >
> > I reply rather late. This problem was solved in v2.6.12, by the patch:
> > drop_buffers() oops fix. Thanks.
> >
> >         Coywolf
> 
>         Stephane
> --
> Stephane Wirtel <stephane.wirtel@belgacom.net>
> 
> 


-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
