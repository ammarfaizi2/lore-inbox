Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292289AbSBBOou>; Sat, 2 Feb 2002 09:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292290AbSBBOor>; Sat, 2 Feb 2002 09:44:47 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:20887 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S292289AbSBBOo2>;
	Sat, 2 Feb 2002 09:44:28 -0500
Date: Sat, 2 Feb 2002 15:44:24 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: SIOCDEVICE ?
Message-ID: <20020202154424.A5845@fafner.intra.cogenit.fr>
In-Reply-To: <200201311304.FAA00344@adam.yggdrasil.com> <20020131181241.A3524@fafner.intra.cogenit.fr> <m3665iqhqn.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3665iqhqn.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Thu, Jan 31, 2002 at 11:26:56PM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
> Francois Romieu <romieu@cogenit.fr> writes:
> 
> > Bug the official HDLC maintainer if you want him to push his work. :o)
> > 
> > PS: I read l-k
> 
> BTW: I do too :-)

Nice. Let's write then.
Your patch doesn't apply against 2.5.3. I did a quick update and noticed the
patch is the sole user of SIOCDEVICE (with dscc4) and SIOCDEVPRIVATE.

Is there some announce/changelog/heads up I missed ?
Is something supposed to replace both ?

-- 
Ueimor
