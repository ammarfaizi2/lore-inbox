Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSCQKuR>; Sun, 17 Mar 2002 05:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288921AbSCQKt6>; Sun, 17 Mar 2002 05:49:58 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:21750 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288830AbSCQKtp>; Sun, 17 Mar 2002 05:49:45 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3C938027.4040805@mandrakesoft.com> 
In-Reply-To: <3C938027.4040805@mandrakesoft.com>  <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Larry McVoy <lm@bitmover.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Mar 2002 10:49:34 +0000
Message-ID: <30393.1016362174@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
>  The system currently punishes Joe in Alaska and  Mikhail in Russia if
> they independently apply the same GNU patch, and  then later on wind
> up attempting to converge trees.

I tried to work round this by applying some patches which I require but 
which Linus hasn't yet taken _only_ in my working tree, not actually 
committing them. 

But then BK wouldn't even let me pull from Linus' tree any more, because I 
had locked and modified files. That also seems to be a fundamental flaw.


--
dwmw2


