Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270716AbRHKESF>; Sat, 11 Aug 2001 00:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270715AbRHKERq>; Sat, 11 Aug 2001 00:17:46 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:1032 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270713AbRHKERk>;
	Sat, 11 Aug 2001 00:17:40 -0400
Date: Sat, 11 Aug 2001 01:17:38 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM nuisance
In-Reply-To: <9l272e$7eo$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0108110117160.3530-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Aug 2001, H. Peter Anvin wrote:

> > I haven't got the faintest idea how to come up with an OOM
> > killer which does the right thing for everybody.
>
> Basically because there is no such thing?

Actually the killer itself isn't the problem.

It's deciding when to let it kick in.

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

