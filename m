Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263264AbTDBXyo>; Wed, 2 Apr 2003 18:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263265AbTDBXyo>; Wed, 2 Apr 2003 18:54:44 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:32260 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S263264AbTDBXym> convert rfc822-to-8bit;
	Wed, 2 Apr 2003 18:54:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH 2.5] OSS opl3sa2: bring in sync with 2.4
Date: Thu, 3 Apr 2003 02:04:44 +0200
User-Agent: KMail/1.4.3
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200303292040.15091.daniel.ritz@gmx.ch> <Pine.LNX.4.50.0304021751490.26002-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0304021751490.26002-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304030204.44258.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 April 2003 00:53, Zwane Mwaikambo wrote:
> On Sat, 29 Mar 2003, Daniel Ritz wrote:
> > hi adam
> >
> > for your oss-2.5 tree. this patch brings sound/oss/opl3sa2.c in sync with
> > 2.4. compiles and works (testes on my toshiba tecra 8000). against
> > 2.5.66-bk
>
> Firstly thank you very much for getting this done. Do you happen to use
> isapnp for configuration?

yes, a plain "modprobe opl3sa2" is enough, no params, nothing in modprobe.conf...
(and it's actually playing sound)

>
> Thanks,
> 	Zwane

rgds
-daniel


