Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWESPST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWESPST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWESPST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:18:19 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:25715 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932338AbWESPSS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:18:18 -0400
X-ME-UUID: 20060519151817217.34F711C00236@mwinf0512.wanadoo.fr
Subject: Re: replacing X Window System !
From: Xavier Bestel <xavier.bestel@free.fr>
To: linux cbon <linuxcbon@yahoo.fr>
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, David Greaves <david@dgreaves.com>
In-Reply-To: <20060519151351.39838.qmail@web26608.mail.ukl.yahoo.com>
References: <20060519151351.39838.qmail@web26608.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1148051890.26628.138.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 19 May 2006 17:18:10 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 17:13, linux cbon wrote:
>  --- Xavier Bestel <xavier.bestel@free.fr> a écrit : 
> > BEWARE !! None of the "Avivo" series (ATI X1000 and
> > later) will work.
> > Only the readon (Radeon 7xxx, Radeon 8xxx, Radeon
> > 9xxx, X600, X700,
> > X800) have drivers.
> > 
> > See DRI homepage for more information.
> > 
> > 	Xav
> 
> 
> Hi,
> 
> does DRI access hardware *directly* ?

Yes it does.

> How does DRI compare with other drivers ?

DRI is not finished for r300 cards (radeon 9600 => X700 IIRC), but it
kind of works. The only other driver I know for r300 is Xorg's radeon,
and it's dead slow.

	Xav


