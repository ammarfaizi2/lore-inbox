Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbTAOSf5>; Wed, 15 Jan 2003 13:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266918AbTAOSf5>; Wed, 15 Jan 2003 13:35:57 -0500
Received: from [66.70.28.20] ([66.70.28.20]:38918 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266908AbTAOSf4>; Wed, 15 Jan 2003 13:35:56 -0500
Date: Wed, 15 Jan 2003 19:44:55 +0100
From: DervishD <raul@pleyades.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: argv0 revisited...
Message-ID: <20030115184455.GB47@DervishD>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA85@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CACA85@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Iñaki :)) (is that right?)

> > welcome. Although I would like a portable solution, any solution that
> > works under *any* Linux kernel is welcome...
> What about mounting /proc from inside your program? Not a big deal, easy
> sollution ... 

    I don't like it, because it should happen at the very beginning
of init. Remember, is not any program, is an init. Should be a more
clean way, I suppose :??

    Raúl
