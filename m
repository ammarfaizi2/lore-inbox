Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUFNPBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUFNPBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 11:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUFNPBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 11:01:39 -0400
Received: from zulo.virutass.net ([62.151.20.186]:45290 "EHLO
	mx.larebelion.net") by vger.kernel.org with ESMTP id S263184AbUFNPAh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 11:00:37 -0400
From: Manuel Arostegui Ramirez <manuel@todo-linux.com>
To: Gianni Tedesco <gianni@scaramanga.co.uk>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] fix for Re: timer + fpu stuff locks my console race
Date: Mon, 14 Jun 2004 17:00:30 +0200
User-Agent: KMail/1.5
Cc: stian@nixia.no, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <25iEn-7bv-3@gated-at.bofh.it> <m3n038o76h.fsf@averell.firstfloor.org> <1087223763.3375.23.camel@sherbert>
In-Reply-To: <1087223763.3375.23.camel@sherbert>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406141700.30545.manuel@todo-linux.com>
X-Virus: by Larebelion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Lunes 14 Junio 2004 16:36, Gianni Tedesco escribió:
> On Sat, 2004-06-12 at 22:25 +0200, Andi Kleen wrote:
> > Please test.
>
> Thats fixed it for me on PIII (Katmai) / 2.6.6.
>
> Exploit runs and runs, no oopsen.

It's also fixed on 2.6.4
-- 
Manuel Arostegui Ramirez #Linux Registered User 200896

