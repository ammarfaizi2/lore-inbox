Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUAFUGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 15:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUAFUGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 15:06:16 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:21378 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S265206AbUAFUGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 15:06:16 -0500
Message-ID: <3FFB1528.2080206@inp-net.eu.org>
Date: Tue, 06 Jan 2004 21:06:00 +0100
From: =?ISO-8859-1?Q?Rapha=EBl_RIGO?= <raphael.rigo@inp-net.eu.org>
User-Agent: Mozilla Thunderbird 0.5a (20031223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1-rc2] SATA problem.
References: <3FD4C785.4080306@jburgess.uklinux.net>	 <3FD5E454.2030404@inp-net.eu.org> <3FD60552.5090903@jburgess.uklinux.net>	 <3FD6094C.5040502@inp-net.eu.org> <3FD60C5D.6010203@jburgess.uklinux.net>	 <3FD60EC9.8040709@inp-net.eu.org> <3FD614DB.7090207@jburgess.uklinux.net>	 <3FD61615.30507@inp-net.eu.org> <3FD6197B.1070704@jburgess.uklinux.net>	 <3FD62990.80708@inp-net.eu.org>  <3FFAFF39.7090606@jburgess.uklinux.net> <1073415714.26330.5.camel@mhcln02>
In-Reply-To: <1073415714.26330.5.camel@mhcln02>
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Hentges wrote:
> FWIW my P4P 800 Deluxe w/ SATA and PATA drives works fine in 2.6.
> The trick for me was to configure "Enhanced Mode, SATA only" in
> the BIOS.
> 
> See http://www.hentges.net/howtos/p4p800_SATA.html for details.
> 
> HTH

Thanks for the help... it is now (partially) working. But a fix in the kernel 
would be better :) (Maybe I should finally start to learn kernel coding)
The partially is because i tried to burn a CD (with k3b without trying anything 
before) => complete freeze.
Raphaël RIGO.
