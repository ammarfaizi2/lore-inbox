Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbTLIVOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266145AbTLIVOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:14:24 -0500
Received: from jib.isi.edu ([128.9.128.193]:49284 "EHLO jib.isi.edu")
	by vger.kernel.org with ESMTP id S266143AbTLIVNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:13:34 -0500
Date: Tue, 9 Dec 2003 13:46:04 -0800
From: Craig Milo Rogers <rogers@isi.edu>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031209214604.GA4542@isi.edu>
References: <3FCDE5CA.2543.3E4EE6AA@localhost> <3FCED34B.5050309@opersys.com> <1070669311.8421.35.camel@imladris.demon.co.uk> <3FD4C9C8.6040709@opersys.com> <br5b54$nbj$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <br5b54$nbj$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.09, bill davidsen wrote:
> In article <3FD4C9C8.6040709@opersys.com>,
> Karim Yaghmour  <karim@opersys.com> wrote:
> | I didn't exactly specify how the interfacing would be done because that's
> | besides the point I'm trying to make (in fact, it's the later part of my
> | email which was most important). But here's two other ways to do it just
> | for the sake of discussion:
> | a) Hard-wired assembly in the driver that calls on the appropriate address
> | with the proper structure offsets etc. No headers used here.
> 
> Well, the addresses and offset specs came from *somewhere*, and I would
> love to hear someone argue that they "just seemed like good values," or
> that reading the header file and then using absolute numbers isn't
> derivative.

	INAL.  Observable facts (such as absolute numbers) aren't
derivative (in the U.S.) because there's no "creativity"***.  See the
famous court decision (... web search ...)  "Feist Publications
v. Rural Telephone Serv. Co.", for example.  Of course, the DCMA (or
other fell beasts) may have superseded that legal doctrine.

					Craig Milo Rogers

*** This raises the possibility that structured numbers might be
    copyrightable.
