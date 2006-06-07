Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWFGWhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWFGWhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWFGWhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:37:22 -0400
Received: from smtp.ono.com ([62.42.230.12]:48465 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S932450AbWFGWhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:37:21 -0400
Date: Thu, 8 Jun 2006 00:36:53 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.17-rc6-mm1
Message-ID: <20060608003653.74c27b2b@werewolf.auna.net>
In-Reply-To: <20060607220704.GA6287@elte.hu>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	<20060607232345.3fcad56e@werewolf.auna.net>
	<20060607220704.GA6287@elte.hu>
X-Mailer: Sylpheed-Claws 2.2.2cvs2 (GTK+ 2.9.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 00:07:04 +0200, Ingo Molnar <mingo@elte.hu> wrote:

> 
> * J.A. Magallón <jamagallon@ono.com> wrote:
> 
> > > - Many more lockdep updates
> > 
> > One missing ;)
> 
> ok, could you try the annotation patch below?

Trace gone, congrats !!

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.16-jam20 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Thu
