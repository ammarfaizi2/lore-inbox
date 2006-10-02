Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWJBJOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWJBJOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWJBJOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:14:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:5430 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750952AbWJBJO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:14:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oLpP1c+v1g5QFdwSulhTBJh5gpbLLRv2J0CPBBE8IGZaBPgTXvjw8US+03RaQHX8ZfV1P7fgdWL/Nlo/dDF+zy+66oPlBH/liYD7hfHI32phU6GQC8KlY+wNFPqtVWv0++4bGGJb9/G18C9rxV7JNAiQ87L7EhbkZonYpSQ+DQY=
Message-ID: <9a8748490610020214r6ecc5cc9nd5f1617d06650234@mail.gmail.com>
Date: Mon, 2 Oct 2006 11:14:28 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Marc Perkel" <marc@perkel.com>
Subject: Re: Maybe it's time to fork the GPL License - create the Linux license?
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <4520D40F.8080500@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060928144028.GA21814@wohnheim.fh-wedel.de>
	 <MDEHLPKNGKAHNMBLJOLKCENGOLAB.davids@webmaster.com>
	 <BAYC1-PASMTP11B5EB1224711DCB6D4F3DAE180@CEZ.ICE>
	 <4520D40F.8080500@perkel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/06, Marc Perkel <marc@perkel.com> wrote:
> Just a thought. Suppose we forked the GPL2 license and created the Linux
> license? (Or some better name) It's kind of clear the Stallman has his
> own ajenda and that it's not compatible with the Linux model. So - lets
> fork it an start a new one.
>
Why? We can just stay with the GPLv2 forever.

> The idea of the new license is as follows. It would be backwards
> compatible with GPL2. It's would eliminate the "or later" clause because
> we have already seen the potential for abuse there.

The "or later" clause is not part of the actual license. It's part of
the preamble.

> How can one agree to
> future licenses without knowing what they are going to be? The other
> feature is that the license is only modified to provide legal
> clarification or to deal with future issues that occur as a result of
> new technology or circumstances that we don't know about yet. If the
> licenses is modified then copyright holders would then have to
> explicitly declare that they accept the modifications by switching to
> the new terms.
>
As things are now we'd already need acceptance from all major
copyright holders to switch license away from GPLv2...

> Anyhow - I'm thinking that Richard Stallman might be more of a liability
> to the GPL movement and that if something can't be worked out with GPLx
> then maybe it's time to just fork the license and come up with a new
> system that is crazy leader proof.
>
> Just suggesting this as an alternative if the FSF folks insist on a
> political ajenda.
>
I don't see the point. RMS can create GPLv3 any way he wants, the
Linux kernel will still be under GPLv2 terms... GPLv3 really doesn't
change anything for the kernel. It would only change something if we
switched the kernel to GPLv3, but doing that would probably be next to
impossible anyway since all copyright holders would need to agree on
the switch and; a) some copyright holders have already publicly stated
that they will not agree to GPLv3 terms, and b) some of the copyright
holders are dead.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
