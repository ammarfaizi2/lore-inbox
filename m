Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUFUKYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUFUKYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 06:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266184AbUFUKYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 06:24:23 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:27908 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266183AbUFUKYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 06:24:21 -0400
Subject: Re: 2.6.7-bk way too fast
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, norberto+linux-kernel@bensa.ath.cx,
       jgarzik@pobox.com
In-Reply-To: <40D69A3F.8060501@tequila.co.jp>
References: <40D64DF7.5040601@pobox.com>
	 <200406210018.04883.lkml@lpbproductions.com>
	 <20040621001612.176bf8e1.akpm@osdl.org>
	 <200406210115.46159.lkml@lpbproductions.com>
	 <40D69A3F.8060501@tequila.co.jp>
Content-Type: text/plain
Date: Mon, 21 Jun 2004 12:24:14 +0200
Message-Id: <1087813454.1691.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 17:20 +0900, Clemens Schwaighofer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Matt H. wrote:
> | I tried from a fresh  2.6.7-mm1 tree  with your patch ( I had to fix
> up the
> | 2nd half of your patch by hand since  it wouldve rejected ).  The results
> | were the same though.
> 
> same for me. I just recomed from scratch and with ACPI debug on.
> 
> I also will check the "vanilla 2.6.7" kernel (is compiling right now).
> but those ACPI changes are only in the mm tree as I can see

AFAIK, those ACPI changes where introduced at 2.6.7-bk2.

