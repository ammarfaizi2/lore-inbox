Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUBYTrt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUBYTrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:47:48 -0500
Received: from palrel13.hp.com ([156.153.255.238]:36550 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261429AbUBYTrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:47:45 -0500
Date: Wed, 25 Feb 2004 11:47:44 -0800
To: Manuel Estrada Sainz <ranty@ranty.pantax.net>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [PATCH] request_firmware(): fixes and polishing.
Message-ID: <20040225194744.GA26085@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <10776728882704@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10776728882704@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 02:34:48AM +0100, Manuel Estrada Sainz wrote:
> 
>  Hi,
> 
>  Please apply.
> 
>  Dmitry Torokhov has been criticizing my code for some days (Thanks Dmitry),
>  and here is the result. It should be ready for -mm tree.
>  
>  Simon Kelly tested the patch series and reported improvement with some
>  problems he was having.

	By the way, this has fixed the problem I was seeing. My only
nit is that it seems you e-mailer is translating some of the chars in
the patch (' ' -> '=20' ; '=' -> '=3D').

	Jean
