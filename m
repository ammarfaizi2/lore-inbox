Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264762AbUFLMuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbUFLMuz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 08:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264749AbUFLMuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 08:50:55 -0400
Received: from zulo.virutass.net ([62.151.20.186]:13005 "EHLO
	mx.larebelion.net") by vger.kernel.org with ESMTP id S264762AbUFLMum convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 08:50:42 -0400
From: Manuel Arostegui Ramirez <manuel@todo-linux.com>
To: stian@nixia.no, linux-kernel@vger.kernel.org
Subject: Re: new kernel bug
Date: Sat, 12 Jun 2004 14:48:24 +0200
User-Agent: KMail/1.5
References: <1191.83.109.11.80.1087044017.squirrel@nepa.nlc.no>
In-Reply-To: <1191.83.109.11.80.1087044017.squirrel@nepa.nlc.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406121448.24569.manuel@todo-linux.com>
X-Virus: by Larebelion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sábado 12 Junio 2004 14:40, stian@nixia.no escribió:
> You can keep an eye on the
> "timer + fpu stuff locks my console race"
> thread I orignaly created when I found the bug or see here for web version:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108704334308688&w=2
>
>
> I'll put on a quick 2.4.26 fix that should work (can't test, since my
> linux box that I have physical access to isn't wired to the Internett
> currently)
>
>
> Stian Skjelstad
> 
I'm going to fix it with that quick solution, I'll upgrade my 2.4.20-8
 to 2.4.26 and the look at the "timer + fpu stuff locks my console race" 
thread.
Lot of thakns, Stian.

Manuel
-- 
Manuel Arostegui Ramirez #Linux Registered User 200896

