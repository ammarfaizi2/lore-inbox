Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbTJUBis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 21:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbTJUBis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 21:38:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262611AbTJUBir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 21:38:47 -0400
To: Ben Collins <bcollins@debian.org>
Cc: marcelo.tosatti@cyclades.com.br, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, James Goodwin <jamesg@filanet.com>
Subject: Re: patch for 2.4.22 sbp2 hang when loaded with devices already connected
References: <ord6csra7h.fsf@free.redhat.lsd.ic.unicamp.br>
	<orbrsba0eg.fsf@free.redhat.lsd.ic.unicamp.br>
	<20031021010610.GB866@phunnypharm.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 20 Oct 2003 23:37:36 -0200
In-Reply-To: <20031021010610.GB866@phunnypharm.org>
Message-ID: <or1xt79xr3.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 20, 2003, Ben Collins <bcollins@debian.org> wrote:

> Please let me send the patch to Marcelo. I have to get this into our
> repo, and merge things around back to Marcelo, else it makes things
> harder later.

Sure, do however you prefer.  Sorry that I wasn't aware of the
procedure, and this ws the first patch I've ever submitted for the
kernel, woohoo! :-)

I just asked around where patches for 2.4 were supposed to be sent,
and got Marcelo's e-mail.  Then I noticed another firewire-related
patch mentioned in the same bug report in Red Hat's bugzilla, saw it
had been posted to these two mailing lists, and thought I'd do that as
well.

Thanks again, your help was extremely useful in nailing the problem
down.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
