Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWAKXXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWAKXXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWAKXXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:23:34 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:51848 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932528AbWAKXXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:23:34 -0500
Message-ID: <43C5937D.7060502@ens-lyon.org>
Date: Wed, 11 Jan 2006 18:23:41 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm3
References: <20060111042135.24faf878.akpm@osdl.org> <43C54FB9.9080906@ens-lyon.org> <20060111184012.GA19604@isilmar.linta.de> <43C55761.1090106@ens-lyon.org> <20060111195553.GA15739@isilmar.linta.de> <43C56A6C.8020707@ens-lyon.org> <20060111212135.GA32021@isilmar.linta.de> <43C58B02.6010601@ens-lyon.org> <20060111230039.GB4541@isilmar.linta.de>
In-Reply-To: <20060111230039.GB4541@isilmar.linta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:

>Many thanks... Could you try out this patch instead of the other one,
>please? get_pcmcia_device() seems to be the buggiest function I've ever
>written, sorry about that...
>  
>
It works, thanks. Good job!

Brice

