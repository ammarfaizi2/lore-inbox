Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263132AbSJBOuV>; Wed, 2 Oct 2002 10:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263136AbSJBOuU>; Wed, 2 Oct 2002 10:50:20 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:19628 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S263132AbSJBOuT>; Wed, 2 Oct 2002 10:50:19 -0400
Date: Wed, 2 Oct 2002 15:45:39 +0100
From: Stig Brautaset <stig@brautaset.org>
To: Nick Sanders <sandersn@btinternet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: menuconfig: no choice of keyboards
Message-ID: <20021002144539.GA827@arwen.brautaset.org>
References: <20021002113053.GA482@arwen.brautaset.org> <200210021431.25941.sandersn@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210021431.25941.sandersn@btinternet.com>
User-Agent: Mutt/1.3.28i
X-Location: London, UK
X-URL: http://brautaset.org
X-KeyServer: wwwkeys.nl.pgp.net
X-PGP/GnuPG-Key: 9336ADC1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02 2002, Nick was overheard saying:
> On Wednesday 02 October 2002 12:30 pm, Stig Brautaset wrote:
> > Nothing happens if I go to the "Input Device Support" section in
> > menuconf, and pick "Keyboards"; I get no new options. Got around it by
> > manually selecting a keyboard in .config to be able to test it further.
> > Either I chose the wrong one, or it just doesn't build it anyway, 'cause
> > the machine would not respond on boot.

> I think you need 'Serial i/o support' just above the 'Keyboards' option

You were indeed right. Sorry for the waste of bandwidth :)

Got it up and running now; a few warnings about unnused variables, but I
guess you guys don't want those reported... or what? :)

Stig, the embarrased one
-- 
brautaset.org
