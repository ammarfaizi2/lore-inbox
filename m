Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271253AbTGPXOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271254AbTGPXOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:14:33 -0400
Received: from aneto.able.es ([212.97.163.22]:7043 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271253AbTGPXOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:14:32 -0400
Date: Thu, 17 Jul 2003 01:29:23 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Gregoire Favre <greg@magma.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 260-t1(ac1) don't boot on my Mandrake Cooker (2573 does)
Message-ID: <20030716232923.GC7263@werewolf.able.es>
References: <20030716195502.GD7158@magma.unil.ch> <20030716211015.GA7263@werewolf.able.es> <20030716212628.GA9308@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030716212628.GA9308@magma.unil.ch>; from greg@magma.unil.ch on Wed, Jul 16, 2003 at 23:26:28 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.16, Gregoire Favre wrote:
> On Wed, Jul 16, 2003 at 11:10:15PM +0200, J.A. Magallon wrote:
> 
> > gcc --version ?
> 
> gcc (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-0.2mdk)
> 
> > Did you build 2.5.73 with the same compiler ?
> 
> Well, no: Mandrake Cooker is really an up to date distribution, the
> 2.5.73 was compiled with the previous rpm of Mandrake gcc...
> I have just updated my system, with new binutils, I'll shall compil
> 2.6.0-test1-ac2 to see if that will do a change ;-)
> 

Jeje ;) I know, see signature.

Resumee: current gcc in cooker is broken.
See this thread in the cooker list:

http://marc.theaimsgroup.com/?t=105822598500004&r=1&w=2


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre5-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.2mdk))
