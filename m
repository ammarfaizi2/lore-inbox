Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVC1OBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVC1OBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 09:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVC1OA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 09:00:57 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:14537 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261825AbVC1N6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:58:43 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Aaron Gyes <floam@sh.nu>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <1112016850.6003.13.camel@laptopd505.fenrus.org>
References: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl>
	 <1112011441.27381.31.camel@localhost.localdomain>
	 <1112016850.6003.13.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 28 Mar 2005 08:57:45 -0500
Message-Id: <1112018265.27381.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 15:34 +0200, Arjan van de Ven wrote:
> > 
> > Anyway, I don't think that the GPL is that powerful to affect things not
> > linked directly with it
> 
> the problem with kernel modules is.. that you actually create quite a
> few lines of code directly from the kernel (via the headers). Also..
> derived work is both broader and smaller than "directly linked". 
> 
> Like if you write an extra chapter to a harry potter novel... even if
> it's not in the same bundle, it's still a derived work. 
> 

If you don't use any of the names of the characters, is it still a
derived work?

Having a GPL wrapper may be legal to do. You won't find out until you
are actually taken to court. I don't see why people are very upset with
doing this, since those that do must work very hard in keeping things
compliant. And those that write the GPL code, can keep things hard for
them, which could just be by ignoring them. Anyone who complains about a
crash that has the nvidia module loaded will not get any help, except
from those that also have the nvidia module.

Writing code that needs wrappers is not derived work, if that code can
also have wrappers for BSD, QNX and perhaps Windows. It may be an added
functionality, that needs some operating system, but if it is a separate
functionality, than it should really work for any operating system, and
thus it is not a derived work. I don't find nvidia modules a derived
work from linux. Since they are used for other operating systems.  And I
believe you'll have a hard time convincing any court that nvidia is a
derived work.


God! I must be in the middle. With management, I'm always fighting to go
GPL, and here on LKML, I'm arguing for proprietary modules.  I must be
going psycho!

-- Steve


