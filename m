Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263170AbTCLNHk>; Wed, 12 Mar 2003 08:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263171AbTCLNHj>; Wed, 12 Mar 2003 08:07:39 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:39870 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S263170AbTCLNHj>;
	Wed, 12 Mar 2003 08:07:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Zack Brown <zbrown@tumblerings.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Wed, 12 Mar 2003 14:22:22 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200303120347.h2C3loEG002703@eeyore.valparaiso.cl>
In-Reply-To: <200303120347.h2C3loEG002703@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030312131822.B2F184085B@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Mar 03 04:47, Horst von Brand wrote:
> ...You need to focus on changes to files,
> not files. I.e., file appeared/dissapeared/changed name/was edited by
> altering lines so and so.

It's useful to make the distinction that "file appeared/dissapeared/changed 
name" are changes to a directory object, while "was edited by altering lines 
so and so" is a change to a file object...

[...]

> > This consists of allowing developers to rename files and directories, and
> > have all repository operations properly recognize and handle this.
>
> And create and destroy. Note "rename" must include moving directories
> around, and moving stuff from one directory to another, etc.

...then this part gets much easier.

Regards,

Daniel

