Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSJRRmM>; Fri, 18 Oct 2002 13:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbSJRRmA>; Fri, 18 Oct 2002 13:42:00 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:55990 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S265255AbSJRRkX>; Fri, 18 Oct 2002 13:40:23 -0400
Date: Fri, 18 Oct 2002 10:39:59 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Gregoire Favre <greg@ulima.unil.ch>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.n* and atyfb: why such colours???
In-Reply-To: <20021010091618.GB2874@ulima.unil.ch>
Message-ID: <Pine.LNX.4.33.0210181039310.10832-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello,
>
> since some kernels revision, it begins to boot with the white on black,
> and the at atyfb initialisation, the white is remplaced by blue and I
> can't read anymore???

It appears to ge a bug in setcolreg. I have seen this problem as well. I
will trace it down.

