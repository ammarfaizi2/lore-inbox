Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUAPHnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 02:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUAPHnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 02:43:45 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:1525 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265310AbUAPHnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 02:43:43 -0500
Date: Fri, 16 Jan 2004 08:43:41 +0100
From: Romain Lievin <romain@rlievin.dyndns.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: True story: "gconfig" removed root folder...
Message-ID: <20040116074341.GA26419@rlievin.dyndns.org>
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv> <20040115212304.GA25296@rlievin.dyndns.org> <Pine.LNX.4.58.0401152245030.27223@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0401152245030.27223@serv>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 15, 2004 at 10:46:48PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 15 Jan 2004, Romain Lievin wrote:
> 
> > I have managed to reproduce bug: make gconfig, go to the '/' directory,
> > type 'root' as file and ... you get a 'root' file. The 'root' directory is
> > destroyed !
> 
> What do you mean with "destroyed"? All I can reproduce here is that it's
> simply moved away, but it's still there!

I mean "destroyed" because my 'root' directory did not exist anymore. When I do
a 'ls', I just see a 'root' file with config within.
Well, "destroyed" may not be the best word. I can tell that it vanished somewhere.
Anyways, I don't have any '*.old' file or directory after that.

> bye, Roman

Romain.
-- 
Romain Li�vin (roms):         <roms@tilp.info>
Web site:                     http://tilp.info
"Linux, y'a moins bien mais c'est plus cher !"






