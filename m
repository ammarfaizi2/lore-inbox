Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbUAPVTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 16:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUAPVTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 16:19:19 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:40076 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S265791AbUAPVTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:19:18 -0500
To: Romain Lievin <romain@rlievin.dyndns.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: True story: "gconfig" removed root folder...
References: <1074177405.3131.10.camel@oebilgen>
	<Pine.LNX.4.58.0401151558590.27223@serv>
	<20040115212304.GA25296@rlievin.dyndns.org>
	<Pine.LNX.4.58.0401152245030.27223@serv>
	<20040116074341.GA26419@rlievin.dyndns.org>
From: Doug McNaught <doug@mcnaught.org>
Date: Fri, 16 Jan 2004 16:18:31 -0500
In-Reply-To: <20040116074341.GA26419@rlievin.dyndns.org> (Romain Lievin's
 message of "Fri, 16 Jan 2004 08:43:41 +0100")
Message-ID: <873caf3848.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romain Lievin <romain@rlievin.dyndns.org> writes:

> I mean "destroyed" because my 'root' directory did not exist anymore. When I do
> a 'ls', I just see a 'root' file with config within.

Try 'ls -a' -- it sounds like the old one is being renamed to a name
that starts with a dot.

-Doug
