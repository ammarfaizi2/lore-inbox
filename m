Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTKCJyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 04:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTKCJyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 04:54:38 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:28689 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261959AbTKCJyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 04:54:37 -0500
Date: Mon, 3 Nov 2003 10:49:13 +0100
From: DervishD <raul@pleyades.net>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Using proc in chroot environments
Message-ID: <20031103094913.GE54@DervishD>
References: <20031102204934.GB54@DervishD> <20031103031012.GA30460@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031103031012.GA30460@mark.mielke.cc>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Mark :)

 * Mark Mielke <mark@mark.mielke.cc> dixit:
> >     I'm using a chroot environment on my main disk as a 'crash test
> > dummy', and I need to access the proc filesystem inside it. Since
> It sounds to me, as if you want something like UML... :-)

    More or less. It's just the chroot is easier for me, but I would
like to test UML someday O:))
 
> chroot environments are traditionally quite minimal, meaning that they
> usually don't require /dev/pts, /proc, etc.

    I know, but I think that UML is unnecessarily complex for me. I
can go with just a chrooted env.
 
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
