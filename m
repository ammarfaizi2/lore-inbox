Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVINJnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVINJnl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVINJnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:43:41 -0400
Received: from mail.permas.de ([195.143.204.226]:41406 "EHLO mail-gw.local")
	by vger.kernel.org with ESMTP id S965122AbVINJnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:43:40 -0400
From: Hartmut Manz <manz@intes.de>
Reply-To: manz@intes.de
Organization: INTES GmbH
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Another 2.6.13-ck3 locks machine after some time, 2.6.12.5 work fine
Date: Wed, 14 Sep 2005 11:43:30 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200509141125.00971.manz@intes.de> <200509141935.19749.kernel@kolivas.org>
In-Reply-To: <200509141935.19749.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509141143.31011.manz@intes.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 14. September 2005 11:35, Con Kolivas wrote:
> On Wed, 14 Sep 2005 19:25, Hartmut Manz wrote:
> > I have also tried to switch to kernel 2.6.13-ck3 and after about 2 hours
> > the machine is completely frozen. I have than applied the proposed patch
> > from Linus for a simmilar problem on 2.6.13.1 but it didn't help.
>
> -ck currently has a unique problem with 250HZ as well. Try 1000 if you are
> using 250.
>
Yes I was using 250 HZ.  
So I will recompile the Kernel now and come back with an answer later

Thank You

Hartmut

> Cheers,
> Con

-- 
-----------------------------------------------------------------------------
Hartmut Manz                                      WWW:    http://www.intes.de
INTES GmbH                                        Phone:  +49-711-78499-29
Schulze-Delitzsch-Str. 16                         Fax:    +49-711-78499-10
D-70565 Stuttgart                                 E-mail: manz@intes.de
   Himmel und Erde werden vergehen; meine Worte aber werden nicht vergehen.
------------------------------------------------------  Markus 13,31 --------

