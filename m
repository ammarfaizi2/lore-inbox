Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbRBYUpG>; Sun, 25 Feb 2001 15:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129732AbRBYUor>; Sun, 25 Feb 2001 15:44:47 -0500
Received: from jalon.able.es ([212.97.163.2]:26076 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129719AbRBYUon>;
	Sun, 25 Feb 2001 15:44:43 -0500
Date: Sun, 25 Feb 2001 21:44:29 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Nick Kurshev <nickols_k@mail.ru>
Cc: "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Probably patch-2.4.1 is not complete
Message-ID: <20010225214429.A1443@werewolf.able.es>
In-Reply-To: <E14X3Ut-000CN7-00@smtp2.port.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14X3Ut-000CN7-00@smtp2.port.ru>; from nickols_k@mail.ru on Sun, Feb 25, 2001 at 19:41:28 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.25 Nick Kurshev wrote:
> Hello!
> 
> I have downloaded a full tarball of linux-kernel-2.4.0 and patches:
> patch-2.4.1 patch-2.4.2.
> But patch-2.4.1 imho it not complete. During linking a linker said about
> unresolved reference:
> __buggy_fxsr_alignment

Are you using pgcc ?
Which compiler do you build kernel with ?

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac3 #1 SMP Fri Feb 23 21:48:09 CET 2001 i686

