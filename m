Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266140AbUFUHPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUFUHPD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUFUHPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:15:03 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:39569 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266137AbUFUHOy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:14:54 -0400
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Clemens Schwaighofer <cs@tequila.co.jp>
Subject: Re: 2.6.7-bk way too fast
Date: Mon, 21 Jun 2004 00:18:04 -0700
User-Agent: KMail/1.6.52
Cc: Linus Torvalds <torvalds@osdl.org>,
       Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
References: <40D64DF7.5040601@pobox.com> <Pine.LNX.4.58.0406202313510.11274@ppc970.osdl.org> <40D688D1.7020308@tequila.co.jp>
In-Reply-To: <40D688D1.7020308@tequila.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406210018.04883.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm simular behavior here. I loaded 2.6.7-mm1 tonite  and  tried  
Andrew's  patch ( which didn't work ) and then Linus's  ( which also didn't 
work ).

Matt H.

On Monday 21 June 2004 12:05 am, Clemens Schwaighofer wrote:
> Linus Torvalds wrote:
> | On Mon, 21 Jun 2004, Norberto Bensa wrote:
> |>Attaaached,    ..cooonfiig  and   dmmesssg.  Note:   iit''s
> |>waaaaaaaaaaaaaaay    too     fffasssst  on X.  Text moode    termiinall
> |>it''ss  oook.
> |
> | Does it fix it to just remove that one line completely?
>
> Neither the first one or removing the line fixes it. My mail pingu in
> gkrellm is still running as he would be totaly on drugs ...
