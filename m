Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271709AbRHUOnt>; Tue, 21 Aug 2001 10:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271710AbRHUOne>; Tue, 21 Aug 2001 10:43:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22430 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271708AbRHUOm6>;
	Tue, 21 Aug 2001 10:42:58 -0400
Date: Tue, 21 Aug 2001 07:43:10 -0700 (PDT)
Message-Id: <20010821.074310.35667105.davem@redhat.com>
To: jes@sunsite.dk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <d3snel8p3a.fsf@lxplus015.cern.ch>
In-Reply-To: <d3wv3x8qro.fsf@lxplus015.cern.ch>
	<20010821.065809.102572680.davem@redhat.com>
	<d3snel8p3a.fsf@lxplus015.cern.ch>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jes Sorensen <jes@sunsite.dk>
   Date: 21 Aug 2001 16:28:09 +0200
   
   However the reason I barked was because of you suggesting we remove
   all firmware or should just have left it in there. If we have a GPL
   violation then IMHO it has to be dealt with immediately, then we can
   look at the damages afterwards.

Lack of copyright does not imply "do whatever you want with it".
The plain fact is that we don't know, and I'm trying to say
"it likely is a problem, let's go find out".

I think the QLogic,ISP driver firmware(s) being distributed is just as
serious an issue as the "obvious" qlogicfc_asm.c violation.

Later,
David S. Miller
davem@redhat.com
