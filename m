Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUAFTB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 14:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUAFTB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 14:01:58 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:50902 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S264855AbUAFTB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 14:01:57 -0500
Subject: Re: [2.6.1-rc2] SATA problem.
From: Matthias Hentges <mailinglisten@hentges.net>
To: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3FFAFF39.7090606@jburgess.uklinux.net>
References: <3FD4C785.4080306@jburgess.uklinux.net>
	 <3FD5E454.2030404@inp-net.eu.org> <3FD60552.5090903@jburgess.uklinux.net>
	 <3FD6094C.5040502@inp-net.eu.org> <3FD60C5D.6010203@jburgess.uklinux.net>
	 <3FD60EC9.8040709@inp-net.eu.org> <3FD614DB.7090207@jburgess.uklinux.net>
	 <3FD61615.30507@inp-net.eu.org> <3FD6197B.1070704@jburgess.uklinux.net>
	 <3FD62990.80708@inp-net.eu.org>  <3FFAFF39.7090606@jburgess.uklinux.net>
Content-Type: text/plain
Organization: 
Message-Id: <1073415714.26330.5.camel@mhcln02>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jan 2004 20:01:55 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW my P4P 800 Deluxe w/ SATA and PATA drives works fine in 2.6.
The trick for me was to configure "Enhanced Mode, SATA only" in
the BIOS.

See http://www.hentges.net/howtos/p4p800_SATA.html for details.

HTH
-- 

Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian Woody. Geek by Nature, Linux by Choice

