Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291429AbSAaXph>; Thu, 31 Jan 2002 18:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291431AbSAaXp1>; Thu, 31 Jan 2002 18:45:27 -0500
Received: from www.transvirtual.com ([206.14.214.140]:23314 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291429AbSAaXpN>; Thu, 31 Jan 2002 18:45:13 -0500
Date: Thu, 31 Jan 2002 15:44:27 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
cc: linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <Pine.LNX.4.33.0201312216460.10027-100000@phobos.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.10.10201311542370.5906-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +	scancode = scancode >> 1;	/* lowest bit is release bit */
> > +	down = scancode & 1;
> 
> Shouldn't that be the other way 'round?

I don't know. Anyone?

