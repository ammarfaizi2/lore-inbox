Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276474AbRJILzu>; Tue, 9 Oct 2001 07:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276468AbRJILzk>; Tue, 9 Oct 2001 07:55:40 -0400
Received: from falka.mfa.kfki.hu ([148.6.72.6]:31152 "EHLO falka.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id <S276343AbRJILzZ>;
	Tue, 9 Oct 2001 07:55:25 -0400
Date: Tue, 9 Oct 2001 13:55:22 +0200 (CEST)
From: Gergely Tamas <dice@mfa.kfki.hu>
To: Marco Berizzi <pupilla@hotmail.com>
cc: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
In-Reply-To: <LAW2-OE29ilTmbtQVi0000079ef@hotmail.com>
Message-ID: <Pine.LNX.4.33.0110091347001.12835-100000@falka.mfa.kfki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

 > Could I try to patch also 2.4.10 kernel?

You can do this 'by hand'. 2.4.10 changed the structure a bit. But I sent
VDA a modified patch some time ago. Maybe just ask him.

 > This patch will be included in kernel 2.4.11?

I don't think so. :(

Honestly I'm not happy about this, but there had beed a large discussion
about it. There were some people which mobo worked right 'out of the box',
and they found that others should patch their kernels by hand to be able
to use their linux boxes. :(((

Gergely

ps: I use this patch too on an ABIT KT7A mobo with Duron 750

