Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSGVApV>; Sun, 21 Jul 2002 20:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSGVApU>; Sun, 21 Jul 2002 20:45:20 -0400
Received: from moutvdomng0.kundenserver.de ([195.20.224.130]:31457 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S315388AbSGVApU>; Sun, 21 Jul 2002 20:45:20 -0400
Date: Sun, 21 Jul 2002 18:43:09 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Jos Hulzink <josh@stack.nl>
cc: Adrian Bunk <bunk@fs.tum.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Szakacsits Szabolcs <szaka@sienet.hu>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <20020721162011.I69041-100000@turtle.stack.nl>
Message-ID: <Pine.LNX.4.44.0207211842230.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 21 Jul 2002, Jos Hulzink wrote:
> Maybe it is an option to add the --I_know_Im_stupid option to the swapoff
> command line ? (Also known as the --force flag). This way we can both
> return an error when the OS lacks memory and force a swapoff.

What's wrong with the current behavior? If the system can't live without 
swap, why forcing it dead?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

