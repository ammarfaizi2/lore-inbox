Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261838AbTC0JY5>; Thu, 27 Mar 2003 04:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbTC0JY5>; Thu, 27 Mar 2003 04:24:57 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:23756 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S261838AbTC0JY4>;
	Thu, 27 Mar 2003 04:24:56 -0500
Subject: Re: Linux 2.4.21-pre6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20030327083610.00b6d4e0@pop.t-online.de>
References: <4.3.2.7.2.20030327083610.00b6d4e0@pop.t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048757887.10476.71.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 27 Mar 2003 10:38:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 08:44, Margit Schubert-While wrote:
> 	Delete chipset recognition in drm_agpsupport.h
> 	It's in 2.5 and the DRM/DRI mainline. Should be
> 	in 2.4.
> 	Support Radeon 9K variants in radeonfb.
> 	

Well...

I have a bunch of quite important radeonfb updates (including all
these new chipset support stuffs) that are waiting for Ani (the
maintainer) to send them to Marcelo.

If that doesn't happen, I may consider pushing them myself though.

Ben.
