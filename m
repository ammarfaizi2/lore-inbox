Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSLZD4Y>; Wed, 25 Dec 2002 22:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSLZD4Y>; Wed, 25 Dec 2002 22:56:24 -0500
Received: from mail.econolodgetulsa.com ([198.78.66.163]:21252 "EHLO
	mail.econolodgetulsa.com") by vger.kernel.org with ESMTP
	id <S262296AbSLZD4W>; Wed, 25 Dec 2002 22:56:22 -0500
Date: Wed, 25 Dec 2002 20:04:32 -0800 (PST)
From: Josh Brooks <user@mail.econolodgetulsa.com>
To: Billy Rose <billyrose@billyrose.net>
cc: bp@dynastytech.com, <linux-kernel@vger.kernel.org>,
       <felipewd@terra.com.br>
Subject: Re: CPU failures ... or something else ?
In-Reply-To: <E18RPFA-0001ci-00@host.ehost4u.biz>
Message-ID: <20021225200357.U6873-100000@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Understood.  Thank you for that diagnosis.

usually it says proc #1 in the error, but the first time it said proc #0 -
is that interesting ?



On Wed, 25 Dec 2002, Billy Rose wrote:

> i agree with felipe, sounds like either a stick of ram is bad, or proc
> #1 is fried (possibly its vrm though).
>
> a DRAC is the dell remote assistant card. it sits in a pci slot, has
> an intel i860 proc on it, and has a 10/100 for a net cable. if you
> have no cards, then it is obviously ruled out.
>
> billy
> =====
> "there's some milk in the fridge that's about to go bad...
> and there it goes..." -bobby
>

