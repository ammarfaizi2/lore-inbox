Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTA2Mjc>; Wed, 29 Jan 2003 07:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbTA2Mjc>; Wed, 29 Jan 2003 07:39:32 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:40832 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S265863AbTA2Mjb>;
	Wed, 29 Jan 2003 07:39:31 -0500
Date: Wed, 29 Jan 2003 06:48:05 -0600 (CST)
From: Thomas Molina <tomolina@cox.net>
X-X-Sender: tomolina@dad.molina
To: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [oops] [2.5.59{,-mm6}] [modules] Inserting modules during boot
 causes oops
In-Reply-To: <200301282319.36723.cb-lkml@fish.zetnet.co.uk>
Message-ID: <Pine.LNX.4.44.0301290647250.1399-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Charles Baylis wrote:

> 
> The last kernel I tried was 2.5.56 which works fine. This oops occurs in 2.5.59
> and 2.5.59-mm6.
> 
> Using modutils 0.9.8 from Debian sid.

I got the same oops using plain 2.5.59 and modutils 0.9.9-pre.

