Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267710AbTASWEw>; Sun, 19 Jan 2003 17:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267711AbTASWEw>; Sun, 19 Jan 2003 17:04:52 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:9410 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S267710AbTASWEv>; Sun, 19 Jan 2003 17:04:51 -0500
Date: Sun, 19 Jan 2003 23:13:51 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre3-ac oops
Message-ID: <20030119221351.GT8325@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301191347310.2280-100000@localhost.localdomain> <3E2B1833.5060203@bogonomicon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2B1833.5060203@bogonomicon.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bryan Andersen <bryan@bogonomicon.net>:
> Patch looks like it solved the problem.  6 kernel compiles
> and 6 mke2fs with bad block scans and the system is still
> up.

Same here. I can actually work using this kernel

> The only thing I'm still seeing that is unusual is this kernel
> message:
> 
>   ide: no cache flush required.

Dito

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
Look what sendmail just dragged in: 
Ah, so if SMTP is a dog, does that imply that sendmail is a cat? It'd
make sense, given that cats will often drag in nasty little dying
things & drop them lovingly in front of you.  
A female cat. Because sometimes, sendmail is a bitch. 

