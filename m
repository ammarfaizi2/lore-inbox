Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWBJUXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWBJUXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWBJUXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:23:10 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:52127 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1751378AbWBJUXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:23:09 -0500
Date: Fri, 10 Feb 2006 21:22:01 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-mm1
Message-ID: <20060210202201.GR25875@kiste.smurf.noris.de>
References: <20060207220627.345107c3.akpm@osdl.org> <2cd57c900602101017l61dd9ddbh@mail.gmail.com> <20060210112530.540fec62.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210112530.540fec62.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.2 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton:
> > 
> > The master branch seems not correct. It should be v2.6.16-rc2-mm1, but
> > it is v2.6.13-rc4-mm1 or something.
> 
> There is a 2.6.16-rc2-mm1 tag in there.  Perhaps Matthias could describe
> how things are organised, recommendations for how people should use that
> tree?
> 
The master branch does not make much sense. The problem is that you
cannot update it -- the -mm tree is always built from scratch. 

On the other hand, cleaning that up makes sense; I'll set "master" to
the current -linus version in my script.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
HARDWARILY adv. In a way pertaining to hardware.  "The system is
   hardwarily unreliable."  The adjective "hardwary" is NOT used.  See
   SOFTWARILY.
				-- From the AI Hackers' Dictionary
